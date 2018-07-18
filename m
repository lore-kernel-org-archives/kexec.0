Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v11 03/15] powerpc, kexec_file: factor out memblock-based
 arch_kexec_walk_mem()
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
 <20180711074203.3019-4-takahiro.akashi@linaro.org>
 <20180716122623.GB7160@dhcp-128-65.nay.redhat.com>
From: James Morse <james.morse@arm.com>
Message-ID: <c8c09929-165a-b710-6993-0b149a0c3b99@arm.com>
Date: Wed, 18 Jul 2018 17:52:03 +0100
MIME-Version: 1.0
In-Reply-To: <20180716122623.GB7160@dhcp-128-65.nay.redhat.com>
Content-Language: en-US
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
To: Dave Young <dyoung@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, davem@davemloft.net, vgoyal@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>

Hi Dave, Akashi,

On 16/07/18 13:26, Dave Young wrote:
> On 07/11/18 at 04:41pm, AKASHI Takahiro wrote:
>> Memblock list is another source for usable system memory layout.
>> So powerpc's arch_kexec_walk_mem() is moved to kexec_file.c so that
>> other memblock-based architectures, particularly arm64, can also utilise
>> it. A moved function is now renamed to kexec_walk_memblock() and merged
>> into the existing arch_kexec_walk_mem() for general use, either resource
>> list or memblock list.
>>
>> A consequent function will not work for kdump with memblock list, but
>> this will be fixed in the next patch.
> 
> If this breaks something, then it would be good to fold the following
> patch in this patch so that bisect can still work?

This patch is just moving code from arch/powerpc that is generic.
powerpc doesn't support kdump via kexec_file, so nothing is damaged by adding
this new code in the next patch.

arm64 would need this kdump support, but it doesn't use it until patch 11.


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
