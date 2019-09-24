Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [RFC PATCH v1 1/1] Add support for arm64 to carry ima measurement
 log in kexec_file_load
References: <20190913225009.3406-1-prsriva@linux.microsoft.com>
 <20190913225009.3406-2-prsriva@linux.microsoft.com>
 <87zhiz1x9l.fsf@morokweng.localdomain>
From: prsriva <prsriva@linux.microsoft.com>
Message-ID: <baf74901-a594-c15d-b93f-f7d0a8c584b8@linux.microsoft.com>
Date: Tue, 24 Sep 2019 13:27:06 -0700
MIME-Version: 1.0
In-Reply-To: <87zhiz1x9l.fsf@morokweng.localdomain>
Content-Language: en-US
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
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: mark.rutland@arm.com, jean-philippe@linaro.org, arnd@arndb.de, yamada.masahiro@socionext.com, sboyd@kernel.org, catalin.marinas@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, takahiro.akashi@linaro.org, kristina.martsenko@arm.org, duwe@lst.de, linux-arm-kernel@lists.infradead.org, james.morse@arm.org, linux-integrity@vger.kernel.org, tglx@linutronix.de, allison@lohutok.net



On 9/19/19 8:07 PM, Thiago Jung Bauermann wrote:
> 
> Hello Prakhar,
> 
> Prakhar Srivastava <prsriva@linux.microsoft.com> writes:
> 
>> During kexec_file_load, carrying forward the ima measurement log allows
>> a verifying party to get the entire runtime event log since the last
>> full reboot since that is when PCRs were last reset.

<snip>

> In the previous patch, you took the powerpc file and made a few
> modifications to fit your needs. This file is now somewhat different
> than the powerpc version, but I don't understand to what purpose. It's
> not different in any significant way.
> 
> Based on review comments from your previous patch, I was expecting to
> see code from the powerpc file moved to an arch-independent part of the
> the kernel and possibly adapted so that both arm64 and powerpc could use
> it. Can you explain why you chose this approach instead? What is the
> advantage of having superficially different but basically equivalent
> code in the two architectures?
> 
> Actually, there's one change that is significant: instead of a single
> linux,ima-kexec-buffer property holding the start address and size of
> the buffer, ARM64 is now using two properties (linux,ima-kexec-buffer
> and linux,ima-kexec-buffer-end) for the start and end addresses. In my
> opinion, unless there's a good reason for it Linux should be consistent
> accross architectures when possible.
> 
> --
> Thiago Jung Bauermann
> IBM Linux Technology Center

I looked at the of_ drivers are it became apparent that the driver calls
were already available for consumption. Adding ima specific code will be
same as adding wrapper code for any other property. Which is true for
all properties, effectively setting the property name and pass through
for other parameters.

I still like to move both implementations to a arch independent code 
path, i could not convince my self that of_*ima is probably the place, 
but if that's the best place?, then i will go ahead and make that change 
as well.

Regarding using two properties, it just seemed more consistent how the
properties(start-end) are being used in the kexec, and hides the inner 
details for the cell structures, thats all.

Its just the placement of the wrapper functions, but once thats done
both archs will call the same.

Thanks,
Prakhar Srivastava

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
