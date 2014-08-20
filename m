Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XK3pK-000759-3K
 for kexec@lists.infradead.org; Wed, 20 Aug 2014 11:13:15 +0000
Received: from 157.15.12.109.rev.sfr.net ([109.12.15.157]
 helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <louis.bouchard@ubuntu.com>)
 id 1XK3ou-0001qN-Ka
 for kexec@lists.infradead.org; Wed, 20 Aug 2014 11:12:48 +0000
From: Louis Bouchard <louis.bouchard@ubuntu.com>
Subject: [PATCH 0/9] Remote kernel crash dump for Debian and Ubuntu
Date: Wed, 20 Aug 2014 13:11:11 +0200
Message-Id: <1408533080-17838-1-git-send-email-louis.bouchard@ubuntu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This set of patches implements the remote kernel crash dump capability
for Debian and Ubuntu.

With this patchset, it is possible to have the result of the makedumpfile
pass or the plain vmcore content to be sent remotely to a server running
sshd or exporting a writable NFS mountpoint.

This new functionality is similar to those currently available on other
distributions, namely RHEL and SLES.

Details on the implementation and tests can be found in the following blog
post :

 * http://caribou.kamikamamak.com/2014/05/20/remote-kernel-crash-dump-for-debian-and-ubuntu/

---

Louis Bouchard (9):
  Add SSH remote dump collection mechanism
  Implement propagate to send ssh key file to remote server
  Add comments to default/kdump-tools to outline functionality
  Add a prefix to the timestamped directory
  Add remote dump information to kdump-config show
  Add NFS remote dump collection
  Add NFS info to kdump-config show
  Reformat of the kdump-tools file
  Add check to avoid SSH and NFS being set together

 debian/kdump-config        | 249 +++++++++++++++++++++++++++++++++++++++++----
 debian/kdump-tools.default |  23 +++++
 2 files changed, 251 insertions(+), 21 deletions(-)

-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
