Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [RFC PATCH v1 1/1] Add support for arm64 to carry ima measurement
 log in kexec_file_load
References: <20190913225009.3406-1-prsriva@linux.microsoft.com>
 <20190913225009.3406-2-prsriva@linux.microsoft.com>
 <1568816111.16709.68.camel@linux.ibm.com>
 <1568841696.4733.3.camel@linux.ibm.com>
 <871rwd2ay8.fsf@morokweng.localdomain>
From: Prakhar Srivastava <prsriva@linux.microsoft.com>
Message-ID: <ed2dc633-c691-6789-9c70-e7d37f436a49@linux.microsoft.com>
Date: Thu, 19 Sep 2019 17:32:04 -0700
MIME-Version: 1.0
In-Reply-To: <871rwd2ay8.fsf@morokweng.localdomain>
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
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: mark.rutland@arm.com, jean-philippe@linaro.org, arnd@arndb.de, yamada.masahiro@socionext.com, sboyd@kernel.org, catalin.marinas@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, takahiro.akashi@linaro.org, kristina.martsenko@arm.org, duwe@lst.de, linux-arm-kernel@lists.infradead.org, james.morse@arm.org, linux-integrity@vger.kernel.org, tglx@linutronix.de, allison@lohutok.net



On 9/18/2019 8:59 PM, Thiago Jung Bauermann wrote:
> Mimi Zohar <zohar@linux.ibm.com> writes:
>
>> On Wed, 2019-09-18 at 10:15 -0400, Mimi Zohar wrote:
>>
>>>> +	uint64_t tmp_start, tmp_end;
>>>> +
>>>> +	propStart = of_find_property(of_chosen, "linux,ima-kexec-buffer",
>>>> +				     NULL);
>>>> +	if (propStart) {
>>>> +		tmp_start = fdt64_to_cpu(*((const fdt64_t *) propStart));
>>>> +		ret = of_remove_property(of_chosen, propStart);
>>>> +		if (!ret) {
>>>> +			return ret;
>>>> +		}
>>>> +
>>>> +		propEnd = of_find_property(of_chosen,
>>>> +					   "linux,ima-kexec-buffer-end", NULL);
>>>> +		if (!propEnd) {
>>>> +			return -EINVAL;
>>>> +		}
>>>> +
>>>> +		tmp_end = fdt64_to_cpu(*((const fdt64_t *) propEnd));
>>>> +
>>>> +		ret = of_remove_property(of_chosen, propEnd);
>>>> +		if (!ret) {
>>>> +			return ret;
>>>> +		}
>>> There seems to be quite a bit of code duplication in this function and
>>> in ima_get_kexec_buffer().  It could probably be cleaned up with some
>>> refactoring.
>> Sorry, my mistake.  One calls of_get_property(), while the other calls
>> of_find_property().
> of_get_property() is a thin wrapper around of_find_property(), so if
> that's the only difference I think they can still be merged.

I will move to using of_get_property and see if i can reduce the code 
further.

Also address other comments by Mimi in my next iteration.

Thanks,

Prakhar Srivastava


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
