Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <58A445B3.4080608@arm.com>
Date: Wed, 15 Feb 2017 12:12:35 +0000
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v32 07/13] arm64: hibernate: preserve kdump image around
 hibernation
References: <20170207080601.5816-1-takahiro.akashi@linaro.org>
 <20170207080904.5974-5-takahiro.akashi@linaro.org>
In-Reply-To: <20170207080904.5974-5-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: mark.rutland@arm.com, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Akashi,

On 07/02/17 08:08, AKASHI Takahiro wrote:
> Since arch_kexec_protect_crashkres() removes a mapping for crash dump
> kernel memory, the loaded contents won't be preserved around hibernation.
> 
> In this patch, arch_kexec_(un)protect_crashkres() are additionally called
> before/after hibernation so that the relevant region will be mapped again
> and restored just as the other memory regions are.

Reviewed-by: James Morse <james.morse@arm.com>

A quick test of this took longer than expected (writing to a slow usb device), I
suspect it is save/restoring the whole crash region (which I don't think is a
problem). If someone turns out to use this combination of features I will look
at improving this, (almost certainly requires core-code changes).


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
