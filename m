Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <e275e8c8b8d81d97b6a28b860820a27c.squirrel@twosheds.infradead.org>
In-Reply-To: <20170404054144.GG16309@linaro.org>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
 <20170328065130.16019-2-takahiro.akashi@linaro.org>
 <1491207492.6020.8.camel@infradead.org>
 <20170404054144.GG16309@linaro.org>
Date: Tue, 4 Apr 2017 06:14:55 -0000
Subject: Re: [PATCH v34 04/14] arm64: kdump: reserve memory for crash dump
 kernel
From: "David Woodhouse" <dwmw2@infradead.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, David Woodhouse <dwmw2@infradead.org>, catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com, geoff@infradead.org, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, mark.rutland@arm.com, ard.biesheuvel@linaro.org, panand@redhat.com, sgoel@codeaurora.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Mark Salter <msalter@redhat.com>


> On Mon, Apr 03, 2017 at 09:18:12AM +0100, David Woodhouse wrote:
>>
>> You still have typos here.
>
> I'd like to defer to the maintainers whether we prefer MiB over MB.

It is not really a matter of preference. One is correct; the other is not.

While simple errors can of course be forgiven, I cannot understand why you
would deliberately repeat an error once it has been pointed out to you.


-- 
dwmw2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
