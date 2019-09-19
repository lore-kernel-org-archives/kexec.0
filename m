Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
References: <20190913225009.3406-1-prsriva@linux.microsoft.com>
 <20190913225009.3406-2-prsriva@linux.microsoft.com>
 <1568816111.16709.68.camel@linux.ibm.com>
 <1568841696.4733.3.camel@linux.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH v1 1/1] Add support for arm64 to carry ima measurement
 log in kexec_file_load
In-reply-to: <1568841696.4733.3.camel@linux.ibm.com>
Date: Thu, 19 Sep 2019 00:59:11 -0300
Message-ID: <871rwd2ay8.fsf@morokweng.localdomain>
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
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: mark.rutland@arm.com, jean-philippe@linaro.org, arnd@arndb.de, takahiro.akashi@linaro.org, sboyd@kernel.org, catalin.marinas@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Prakhar Srivastava <prsriva@linux.microsoft.com>, yamada.masahiro@socionext.com, kristina.martsenko@arm.org, duwe@lst.de, allison@lohutok.net, james.morse@arm.org, linux-integrity@vger.kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org


Mimi Zohar <zohar@linux.ibm.com> writes:

> On Wed, 2019-09-18 at 10:15 -0400, Mimi Zohar wrote:
>
>> > +	uint64_t tmp_start, tmp_end;
>> > +
>> > +	propStart = of_find_property(of_chosen, "linux,ima-kexec-buffer",
>> > +				     NULL);
>> > +	if (propStart) {
>> > +		tmp_start = fdt64_to_cpu(*((const fdt64_t *) propStart));
>> > +		ret = of_remove_property(of_chosen, propStart);
>> > +		if (!ret) {
>> > +			return ret;
>> > +		}
>> > +
>> > +		propEnd = of_find_property(of_chosen,
>> > +					   "linux,ima-kexec-buffer-end", NULL);
>> > +		if (!propEnd) {
>> > +			return -EINVAL;
>> > +		}
>> > +
>> > +		tmp_end = fdt64_to_cpu(*((const fdt64_t *) propEnd));
>> > +
>> > +		ret = of_remove_property(of_chosen, propEnd);
>> > +		if (!ret) {
>> > +			return ret;
>> > +		}
>> 
>> There seems to be quite a bit of code duplication in this function and
>> in ima_get_kexec_buffer().  It could probably be cleaned up with some
>> refactoring.
>
> Sorry, my mistake.  One calls of_get_property(), while the other calls
> of_find_property().

of_get_property() is a thin wrapper around of_find_property(), so if
that's the only difference I think they can still be merged.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
