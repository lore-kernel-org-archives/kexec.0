Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr810081.outbound.protection.outlook.com
 ([40.107.81.81] helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hb8eE-0004eV-CK
 for kexec@lists.infradead.org; Wed, 12 Jun 2019 19:11:04 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel e820
 table
Date: Wed, 12 Jun 2019 19:10:59 +0000
Message-ID: <d89ef4ef-b85a-ea94-acdf-2eed5666ed78@amd.com>
References: <20190607174211.GN20269@zn.tnic>
 <20190608035451.GB26148@MiWiFi-R3L-srv> <20190608091030.GB32464@zn.tnic>
 <20190608100139.GC26148@MiWiFi-R3L-srv> <20190608100623.GA9138@zn.tnic>
 <20190608102659.GA9130@MiWiFi-R3L-srv> <20190610113747.GD5488@zn.tnic>
 <20190612015549.GI26148@MiWiFi-R3L-srv> <20190612151033.GJ32652@zn.tnic>
 <3dfa5985-008a-20d8-5171-cfe96807c303@amd.com>
 <20190612180724.GP32652@zn.tnic>
In-Reply-To: <20190612180724.GP32652@zn.tnic>
Content-Language: en-US
Content-ID: <6B2A2BFAEA6F6448B86755F60ED6E82C@namprd12.prod.outlook.com>
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
To: Borislav Petkov <bp@alien8.de>
Cc: "x86@kernel.org" <x86@kernel.org>, lijiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "luto@kernel.org" <luto@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "dyoung@redhat.com" <dyoung@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

On 6/12/19 1:07 PM, Borislav Petkov wrote:
> On Wed, Jun 12, 2019 at 04:52:22PM +0000, Lendacky, Thomas wrote:
>> I think the discussion ended up being that debuginfo wasn't being stripped
>> from the kernel and initrd (mainly the initrd).  What are the sizes of
>> the kernel and initrd that you are loading for kdump via kexec?
>>
>> From previous post:
>>   kexec -s -p /boot/vmlinuz-5.2.0-rc3+ --initrd=/boot/initrd.img-5.2.0-rc3+
> 
> You mean those sizes?
> 
> $ ls -lh /boot/vmlinuz-5.2.0-rc3+ /boot/initrd.img-5.2.0-rc3+
> -rw-r--r-- 1 root root 7.8M Jun 10 12:53 /boot/initrd.img-5.2.0-rc3+
> -rw-r--r-- 1 root root 6.7M Jun 10 12:53 /boot/vmlinuz-5.2.0-rc3+
> 
> That should fit easily in 256M :)

Certainly seems like they should. I know there are other things that are
loaded, but that should be plenty of room. I wonder if Baoquan or Lianbo
could track where things are being loaded to see if everything is being
calculated and placed properly.

Thanks,
Tom

> 
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
