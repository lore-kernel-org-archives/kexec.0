Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <58249B18.6030702@arm.com>
Date: Thu, 10 Nov 2016 16:06:48 +0000
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v27 0/9] arm64: add kdump support
References: <20161102044959.11954-1-takahiro.akashi@linaro.org>
 <20161104030025.GC381@linaro.org>
In-Reply-To: <20161104030025.GC381@linaro.org>
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
Cc: mark.rutland@arm.com, geoff@infradead.org, catalin.marinas@arm.com, Ruslan Bilovol <rbilovol@cisco.com>, will.deacon@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Akashi,

On 04/11/16 03:00, AKASHI Takahiro wrote:
> For easier testing, I pushed my patches to:
> https://git.linaro.org/people/takahiro.akashi/linux-aarch64.git arm64/kdump
> https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/kdump

Aha, thanks. That saved hopping around the mail archives to find the right set
of kdump patches.

> If anybody tries my patches, please let me know the result.

I gave this a spin on Juno with all the page-size va-bits combinations it
supports and used 'crash' to fish around in the resulting image. I also tested
the 4K/39 combination on Seattle that caused us problems in the past.

If its useful:
Tested-by: James Morse <james.morse@arm.com>

So the last thing is review/acks on patch 1
"memblock: add memblock_cap_memory_range()"?



Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
