Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v24 0/9] arm64: add kdump support
References: <20160809015248.28414-1-takahiro.akashi@linaro.org>
 <0267060a-d380-2e7a-0c33-0084bfc46d97@caviumnetworks.com>
 <20160831053109.GR20080@linaro.org>
 <cca40a49-3500-ded8-35a7-053adf79d12b@caviumnetworks.com>
 <20160905081501.GA16712@linaro.org>
 <976ca1f8-5efb-b45c-19b8-bde7bd06f5b8@caviumnetworks.com>
 <57CEE1E5.7040206@arm.com>
 <35f81eb9-8bd0-16ae-e04d-5ea4b30c0ad6@caviumnetworks.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <57CEF1D8.3000904@arm.com>
Date: Tue, 6 Sep 2016 17:42:00 +0100
MIME-Version: 1.0
In-Reply-To: <35f81eb9-8bd0-16ae-e04d-5ea4b30c0ad6@caviumnetworks.com>
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
To: Manish Jaggi <mjaggi@caviumnetworks.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com, geoff@infradead.org, kexec@lists.infradead.org, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

On 06/09/16 17:15, Manish Jaggi wrote:
> 
>>> In my setup the GICD_CTRL[RWP] bit is not cleared in the
>>> crashkernels' distributor init function.
>>
>> Which instance is failing? The initial one (just after the initial
>> disable)? Or the one called from gic_dist_config()?
>>
> In crash kernel, when the GICD_CTRL is set to 0x0, RWP is not getting clear.
> And is never cleared for any subsequent writes.

That's weird. It means writes are still pending, and never drained. What
happens if you put a dsb(sy) in the wait_for_rwp() loop?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
