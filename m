Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OgY3z-00056E-1W
	for kexec@lists.infradead.org; Wed, 04 Aug 2010 07:06:56 +0000
Date: Wed, 4 Aug 2010 16:06:48 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [rfc] Merge kexec-tools into the kernel tree
Message-ID: <20100804070647.GB24064@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Michael Neuling <mikey@neuling.org>, Linus Torvalds <torvalds@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>

Hi,

After all the excitement of relocating kexec-tools from
one location on kernel.org to another last week it was
suggested to me by Michael Neuling that the merging
kexec-tools into the kernel tree would be a good idea.

Given that there have been a bunch of issues with kexec
on power that this would resolve. and there is precedence
for tools in the kernel tree, this sounds entirely reasonable to me.
So with my kexec-tools maintainer hat on, I would like to start
a conversation about this.

In order to move the conversation along I have prepared a tree -
a recent clone of Linus's tree + kexec tools.

http://git.kernel.org/?p=linux/kernel/git/horms/kexec-tools-in-kernel-tree.git

I think that a good next step would be to get this tree into linux-next.
And then if all goes well, as Linus to pull the change some time in the future.





For reference the steps taken to make the tree above were roughly as follows.
Thanks to Michael for assistance with this.

git clone
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
git clone git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

cd linux-2.6

git remote add -f kexec ../kexec-tools
git merge -s ours --no-commit kexec/master
git read-tree --prefix=tools/kexec/ -u kexec/master
git commit -m "Merge kexec-tools into subdirectory tools/kexec"


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
