Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZrJYC-0004bh-7t
 for kexec@lists.infradead.org; Wed, 28 Oct 2015 05:45:32 +0000
Message-Id: <20151028054134.200833741@redhat.com>
Date: Wed, 28 Oct 2015 13:41:34 +0800
From: dyoung@redhat.com
Subject: [kexec-tools PATCH 0/3] New option to avoid copying old root param
 from 1st kernel cmdline 
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
Cc: jstodola@redhat.com, horms@verge.net.au

Hi,

Here is the update patches for adding a new option --dt-no-old-root.
Per previously discussion with Simon, we should consider the compatibility 
issue for changing the old behavior. Thus a new option is necessary

The 1st patch move the copying code to another function. The other two patches
are for adding arch dependent option for arm and ppc64.

Tested kexec load on both arm and ppc64 machines.

For the latter two patches, some usage lines are over 80 characters, but I just
keep same with original formats. I prefer to fix it in other patches. If you
think it really need being fixed in this patchset please let me know, I can
update them again.

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
