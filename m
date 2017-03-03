Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cjdHL-0008Cd-Vz
 for kexec@lists.infradead.org; Fri, 03 Mar 2017 02:49:14 +0000
Received: by mail-pg0-f44.google.com with SMTP id 25so38739348pgy.0
 for <kexec@lists.infradead.org>; Thu, 02 Mar 2017 18:48:51 -0800 (PST)
Subject: Re: [Makedumpfile Patch v3 7/7] mem-usage: allow to work only with -f
 for kernel version < 4.11
References: <cover.1488443170.git.panand@redhat.com>
 <6689d9cf1e69f79b0e8c74ecab8e003e5507a79b.1488443170.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701EAABEE@BPXM01GP.gisp.nec.co.jp>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <3b32aab8-0cbe-fb9a-f884-3b0713717aca@redhat.com>
Date: Fri, 3 Mar 2017 08:18:47 +0530
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701EAABEE@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "dyoung@redhat.com" <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>



On Friday 03 March 2017 07:40 AM, Atsushi Kumagai wrote:
>> +		if (info->kernel_version < KERNEL_VERSION(4, 11, 0) &&
>> +				!info->flag_force) {
>> +			MSG("mem-usage not supported for this kernel.\n");
>> +			MSG("You can try with -f if your kernel's kcore has valid p_paddr\n");
>> +			goto out;
>> +		}
> You forgot to set COMPLETED to retcd before goto.
> The behavior will be different from the v2 patch.


I had thought about it. Should not an unsupported feature be a FAILED case?

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
