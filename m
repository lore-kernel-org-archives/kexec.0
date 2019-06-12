Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr680059.outbound.protection.outlook.com
 ([40.107.68.59] helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hb6U5-0006sg-Rc
 for kexec@lists.infradead.org; Wed, 12 Jun 2019 16:52:27 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel e820
 table
Date: Wed, 12 Jun 2019 16:52:22 +0000
Message-ID: <3dfa5985-008a-20d8-5171-cfe96807c303@amd.com>
References: <20190423013007.17838-1-lijiang@redhat.com>
 <12847a03-3226-0b29-97b5-04d404410147@redhat.com>
 <20190607174211.GN20269@zn.tnic> <20190608035451.GB26148@MiWiFi-R3L-srv>
 <20190608091030.GB32464@zn.tnic> <20190608100139.GC26148@MiWiFi-R3L-srv>
 <20190608100623.GA9138@zn.tnic> <20190608102659.GA9130@MiWiFi-R3L-srv>
 <20190610113747.GD5488@zn.tnic> <20190612015549.GI26148@MiWiFi-R3L-srv>
 <20190612151033.GJ32652@zn.tnic>
In-Reply-To: <20190612151033.GJ32652@zn.tnic>
Content-Language: en-US
Content-ID: <6679569A387EBA448563B6CE4288BD12@namprd12.prod.outlook.com>
MIME-Version: 1.0
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
To: Borislav Petkov <bp@alien8.de>, Baoquan He <bhe@redhat.com>
Cc: "x86@kernel.org" <x86@kernel.org>, lijiang <lijiang@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "luto@kernel.org" <luto@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "dyoung@redhat.com" <dyoung@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

On 6/12/19 10:10 AM, Borislav Petkov wrote:
> On Wed, Jun 12, 2019 at 09:55:49AM +0800, Baoquan He wrote:
>> With further investigation, the failure after applying Tom's patch is
>> caused by OOM. When increase crashkernel reservation to 512M, kdump
>> kernel can boot successfully. I noticed your crashkernel reservation is
>> 256M, that will fail and stuck there very possibly.
>>
>> So Tom's patch can fix the issue. We need further check why much more
>> crashkernel memory is needed on those AMD boxes with sme support..
> 
> Yes, 256M for a kexec kernel sounds pretty much enough to me. So there's
> something else at play here. I wonder if that workarea after _end, from
> Tom's patch, needs so much room...

I think the discussion ended up being that debuginfo wasn't being stripped
from the kernel and initrd (mainly the initrd).  What are the sizes of
the kernel and initrd that you are loading for kdump via kexec?

From previous post:
  kexec -s -p /boot/vmlinuz-5.2.0-rc3+ --initrd=/boot/initrd.img-5.2.0-rc3+

Thanks,
Tom

> 
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
