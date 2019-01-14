Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj6Q9-00012t-E4
 for kexec@lists.infradead.org; Mon, 14 Jan 2019 17:53:11 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
Date: Mon, 14 Jan 2019 17:48:48 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC035661E8@BPXM09GP.gisp.nec.co.jp>
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190110121944.6050-2-lijiang@redhat.com> <20190111123300.GE4729@zn.tnic>
In-Reply-To: <20190111123300.GE4729@zn.tnic>
Content-Language: en-US
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
To: Borislav Petkov <bp@alien8.de>, Lianbo Jiang <lijiang@redhat.com>
Cc: "bhe@redhat.com" <bhe@redhat.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "anderson@redhat.com" <anderson@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "dyoung@redhat.com" <dyoung@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

On 1/11/2019 7:33 AM, Borislav Petkov wrote:
> On Thu, Jan 10, 2019 at 08:19:43PM +0800, Lianbo Jiang wrote:
>> +init_uts_ns.name.release
>> +------------------------
>> +
>> +The version of the Linux kernel. Used to find the corresponding source
>> +code from which the kernel has been built.
>> +
> 
> ...
> 
>> +
>> +init_uts_ns
>> +-----------
>> +
>> +This is the UTS namespace, which is used to isolate two specific
>> +elements of the system that relate to the uname(2) system call. The UTS
>> +namespace is named after the data structure used to store information
>> +returned by the uname(2) system call.
>> +
>> +User-space tools can get the kernel name, host name, kernel release
>> +number, kernel version, architecture name and OS type from it.
> 
> Already asked this but no reply so lemme paste my question again:
> 
> "And this document already fulfills its purpose - those two vmcoreinfo
> exports are redundant and the first one can be removed.
> 
> And now that we agreed that VMCOREINFO is not an ABI and is very tightly
> coupled to the kernel version, init_uts_ns.name.release can be removed,
> yes?
> 
> Or is there anything speaking against that?"

As for makedumpfile, it will be not impossible to remove the
init_uts_ns.name.relase (OSRELEASE), but some fixes are needed.
Because historically OSRELEASE has been a kind of a mandatory entry
in vmcoreinfo from the beginning of vmcoreinfo, so makedumpfile uses
its existence to check whether a vmcoreinfo is sane.

Also, I think crash also will need to be fixed if it is removed.
So I hope it will be left as it is.

Thanks,
Kazu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
