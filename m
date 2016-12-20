Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cJMVH-0008Nb-9T
 for kexec@lists.infradead.org; Tue, 20 Dec 2016 15:39:02 +0000
Received: by mail-wm0-f45.google.com with SMTP id c184so35185231wmd.0
 for <kexec@lists.infradead.org>; Tue, 20 Dec 2016 07:38:38 -0800 (PST)
Subject: Re: [PATCHv2 2/2] [fs] proc/vmcore: check the dummy place holder for
 offline cpu to avoid warning
References: <1482113327-19103-1-git-send-email-piliu@redhat.com>
 <1482113327-19103-2-git-send-email-piliu@redhat.com>
 <20161219024018.GB29921@dhcp-128-65.nay.redhat.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <6691e874-e47a-0028-a2f8-59e431613d6f@redhat.com>
Date: Tue, 20 Dec 2016 21:08:29 +0530
MIME-Version: 1.0
In-Reply-To: <20161219024018.GB29921@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>, Pingfan Liu <piliu@redhat.com>
Cc: Xunlei Pang <xpang@redhat.com>, kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>, kernelfans@gmail.com



On Monday 19 December 2016 08:10 AM, Dave Young wrote:
> Hi, Pingfan
>
> On 12/19/16 at 10:08am, Pingfan Liu wrote:
>> > kexec-tools always allocates program headers for present cpus. But
>> > when crashing, offline cpus have dummy headers. We do not copy these
>> > dummy notes into ELF file, also have no need of warning on them.
> I still think it is not worth such a fix, if you feel a lot of warnings
> in case large cpu numbers, I think you can change the pr_warn to
> pr_warn_once, we do not care the null cpu notes if it has nothing bad
> to the vmcore.
>

I agree. Warning is more like information here. May be, we can count the 
number of times real_sz was 0, and then can print an info at the end in 
stead of warning, like..."N number of CPUs would have been offline, 
PT_NOTE entries was absent for them."

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
