Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d854I-0002xv-UT
 for kexec@lists.infradead.org; Tue, 09 May 2017 13:20:53 +0000
Received: by mail-pg0-f51.google.com with SMTP id o3so52934560pgn.2
 for <kexec@lists.infradead.org>; Tue, 09 May 2017 06:20:25 -0700 (PDT)
Subject: Re: [Makedumpfile PATCH] elf_info: fix file_size if segment is
 excluded
References: <67b01a34efb197a9bafe002dd9775bc094d8bd6e.1494247220.git.panand@redhat.com>
 <7FA68CAA-173B-4988-A0E3-83DE747422FC@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EC87C4@BPXM01GP.gisp.nec.co.jp>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <06c98223-3f59-e3e2-2672-62e9e266616e@redhat.com>
Date: Tue, 9 May 2017 18:50:19 +0530
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701EC87C4@BPXM01GP.gisp.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Baoquan He <bhe@redhat.com>
Cc: "dyoung@redhat.com" <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>



On Tuesday 09 May 2017 07:59 AM, Atsushi Kumagai wrote:
>>> +                temp_seg.file_size = temp_seg.phys_end
>>> +                    - temp_seg.phys_start;
>>>
>>>                (*pt_loads)[i].virt_end = kvstart - 1;
>>>                (*pt_loads)[i].phys_end =  start - 1;
>>> +                (*pt_loads)[i].file_size -= temp_seg.file_size;
> I think we should additionally subtract (end - start), right ?
> This code seems to leave Crash Kernel region for the former half of PT_LOAD.

yes, you are right.

Will send v2.

Thanks for review.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
