Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TQKT8-0000Zf-7p
 for kexec@lists.infradead.org; Mon, 22 Oct 2012 16:03:13 +0000
Message-ID: <50856DFE.8000601@zytor.com>
Date: Mon, 22 Oct 2012 09:02:06 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v1 0/2] x86, apic: Disable BSP if boot cpu is AP
References: <3E5A0FA7E9CA944F9D5414FEC6C7122030B0DD68@ORSMSX105.amr.corp.intel.com>
 <20121016.140313.279437418.d.hatayama@jp.fujitsu.com>
 <3E5A0FA7E9CA944F9D5414FEC6C7122030B0DD91@ORSMSX105.amr.corp.intel.com>
 <20121016.153817.42643171.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20121016.153817.42643171.d.hatayama@jp.fujitsu.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: fenghua.yu@intel.com, len.brown@intel.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, ebiederm@xmission.com, mingo@elte.hu, tglx@linutronix.de, vgoyal@redhat.com

On 10/15/2012 11:38 PM, HATAYAMA Daisuke wrote:
>
> Thanks for pointing out this. And I've recalled my investigation in
> the past now. So I want to stop retrying your patch v9 now. This NMI
> method is definitely not applicable to 2nd kernel without any change.
>
> Your NMI method assumes BSP thread is halting in play dead loop. But
> on the 2nd kernel, BSP is halting in the 1st kernel (or possibly in a
> fatail system error). Even if throwing NMI to BSP, it goes back to the
> 1st kernel soon again. I at least confirmed NMI handler is executed in
> this case.
>
> Also, throwing NMI changes stack in the 1st kernel, which is
> unpermissible from kdump's perspective. But x86_64 uses Interrupt
> Stack Table (IST), in which stack switching is not performed. So 2nd
> kernel's stack is used at least on x86_64.
>
> To sum up, to apply NMI method in the 2nd kernel, I think it necessary
> to modify contexts pushed on the stack so execution goes to the 2nd
> kernel's start_secondary() while initializing its state
> appropreately.
>
> Also I think it necessary to discuss whether this NMI method is
> reliable enough for kdump use.
>

I think it's pretty clear it is *not*.  NMI or monitor would either have 
to rely on context set up by the first kernel, which simply isn't safe. 
  Out of those two options, a monitor would actually be safer, since it 
can be self-contained in a completely different way.

However, it seems that running on N-1 CPUs in kdump is perfectly acceptable.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
