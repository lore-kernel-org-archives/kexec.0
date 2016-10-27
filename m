Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bzcyk-0005K3-D6
 for kexec@lists.infradead.org; Thu, 27 Oct 2016 05:11:52 +0000
Received: by mail-qk0-f175.google.com with SMTP id n189so30632725qke.0
 for <kexec@lists.infradead.org>; Wed, 26 Oct 2016 22:11:29 -0700 (PDT)
Subject: Re: [PATCH Makedumpfile 0/4] x86_64: Fix page_offset for randomized
 base enabled
References: <cover.1477327674.git.panand@redhat.com>
 <20161027023743.GA20446@dhcp-128-65.nay.redhat.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <1d466d00-fe18-072d-b050-f2dcd29f7858@redhat.com>
Date: Thu, 27 Oct 2016 10:41:23 +0530
MIME-Version: 1.0
In-Reply-To: <20161027023743.GA20446@dhcp-128-65.nay.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org, bhe@redhat.com



On Thursday 27 October 2016 08:07 AM, Dave Young wrote:
> According to our test, with these patches the dumped vmcore is correct
> which means simple crash test `bt` works. But the saved vmcore size is
> larger than before.
>
> I collected two --message-level 31 logs with/without your patches, the
> kernel kaslr was disabled during my test so that we can focus on the
> vmcore size issue, it looks like mem_map address was not collected
> correctly.
>
> [please ignore the patched log extra debug message I added]

Hummm..thanks for pointing it out.

Seems patch 1/4 is wrong.

with this patch page_offset = ffffffff80000000
while with original code page_offset = ffff880000000000

Trying to see where it is wrong

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
