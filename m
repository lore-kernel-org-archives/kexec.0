Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UEu7Z-0004a4-Gc
 for kexec@lists.infradead.org; Mon, 11 Mar 2013 04:13:58 +0000
Message-ID: <513D5962.7000209@zytor.com>
Date: Sun, 10 Mar 2013 21:11:14 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/2] x86, apic: Disable BSP if boot cpu is AP
References: <20121026.122406.13396329.d.hatayama@jp.fujitsu.com>
 <87r4oloopm.fsf@xmission.com>
 <20130311.100721.32982204.d.hatayama@jp.fujitsu.com>
 <20130311.111352.105946462.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20130311.111352.105946462.d.hatayama@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: len.brown@intel.com, fenghua.yu@intel.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, ebiederm@xmission.com, tglx@linutronix.de, mingo@elte.hu, vgoyal@redhat.com

On 03/10/2013 07:13 PM, HATAYAMA Daisuke wrote:
> 
> It seems to me that at least there needs to be the following design
> policy for multiple CPUs on the 2nd kenrel:
> 
> - There's no firmware, kernel components and modules that depend on
>   BSP flag being kept set on the original BSP flag and never set BSP
>   flag of any of the existing CPUs again at runtime.
> 

And that is provably false in the case of firmware.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
