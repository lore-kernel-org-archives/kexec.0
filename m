Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bLQNB-0003wH-QY
 for kexec@lists.infradead.org; Fri, 08 Jul 2016 07:38:54 +0000
Received: by mail-wm0-x244.google.com with SMTP id k123so3284011wme.2
 for <kexec@lists.infradead.org>; Fri, 08 Jul 2016 00:38:32 -0700 (PDT)
Date: Fri, 8 Jul 2016 09:38:28 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] kexec: Fix kdump failure with notsc
Message-ID: <20160708073828.GA3216@gmail.com>
References: <1467886646-2638-1-git-send-email-weijg.fnst@cn.fujitsu.com>
 <87r3b5z626.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87r3b5z626.fsf@x220.int.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fenghua.yu@intel.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, Wei Jiangang <weijg.fnst@cn.fujitsu.com>


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> Sigh.  Can we please just do the work to rip out the apic shutdown code from the 
> kexec on panic code path?
> 
> I forgetting details but the only reason we have do any apic shutdown is bugs in 
> older kernels that could not initialize a system properly if we did not shut 
> down the apics.
> 
> I certainly don't see an issue with goofy cases like notsc not working on a 
> crash capture kernel if we are not initializing the hardware properly.
> 
> The strategy really needs to be to only do the absolutely essential hardware 
> shutdown in the crashing kernel, every adintional line of code we execute in the 
> crashing kernel increases our chances of hitting a bug.

Fully agreed.

> Under that policy things like requring we don't pass boot options that inhibit 
> the dump catpure kernel from initializing the hardware from a random state are 
> reasonable requirements.  AKA I don't see any justification in this as to why we 
> would even want to support notsc on the dump capture kernel.  Especially when 
> things clearly work when that option is not specified.

So at least on the surface it appears 'surprising' that the 'notsc' option (which, 
supposedly, disables TSC handling) interferes with being able to fully boot. Even 
if 'notsc' is specified we are still using the local APIC, right?

So it might be a good idea to find the root cause of this bootup fragility even if 
'notsc' is specified. And I fully agree that it should be fixed in the bootup path 
of the dump kernel, not the crash kernel reboot path.

Thanks,

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
