Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bze2t-00042X-SQ
 for kexec@lists.infradead.org; Thu, 27 Oct 2016 06:20:12 +0000
Date: Thu, 27 Oct 2016 14:19:45 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH Makedumpfile 0/4] x86_64: Fix page_offset for randomized
 base enabled
Message-ID: <20161027061945.GA23354@dhcp-128-65.nay.redhat.com>
References: <cover.1477327674.git.panand@redhat.com>
 <20161027023743.GA20446@dhcp-128-65.nay.redhat.com>
 <20161027025437.GA20670@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20161027025437.GA20670@dhcp-128-65.nay.redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Pratyush Anand <panand@redhat.com>
Cc: anderson@redhat.com, ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org, bhe@redhat.com

On 10/27/16 at 10:54am, Dave Young wrote:
> I put the cped-vmcore/vmlinux here:
> https://people.redhat.com/~ruyang/test/
> 
> Adding Dave Anderson for any comments about the vmcore correctness from
> crash point of view..
> 

Since the reason has been found, the page_offset was not correct, I
tested with a changed version of patch 1, it works. Please ignore the
test vmcore, I deleted them.

Here is a new tarball which could be used by Dave to verify the kaslr, I
enabled kaslr, also saved vmlinux/cped vmcore/makedumpfile saved vmcore
in a tarball below.
http://people.redhat.com/~ruyang/test/vmcore-test.tar.gz

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
