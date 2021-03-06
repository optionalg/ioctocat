#import "UserObjectCell.h"
#import "GHUser.h"


@interface UserObjectCell ()
@property(nonatomic,readonly)GHUser *object;
@property(nonatomic,weak)IBOutlet UILabel *loginLabel;
@property(nonatomic,weak)IBOutlet UIImageView *gravatarView;
@end


@implementation UserObjectCell

- (void)awakeFromNib {
	self.gravatarView.layer.cornerRadius = 3;
	self.gravatarView.layer.masksToBounds = YES;
}

- (void)dealloc {
	[self.userObject removeObserver:self forKeyPath:kGravatarKeyPath];
}

- (void)setUserObject:(id)userObject {
	[self.object removeObserver:self forKeyPath:kGravatarKeyPath];
	_userObject = userObject;
	self.loginLabel.text = self.object.login;
	[self.object addObserver:self forKeyPath:kGravatarKeyPath options:NSKeyValueObservingOptionNew context:nil];
	if (self.object.gravatar) self.gravatarView.image = self.object.gravatar;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:kGravatarKeyPath] && self.object.gravatar) {
		self.gravatarView.image = self.object.gravatar;
	}
}

- (GHUser *)object {
	return _userObject;
}

@end