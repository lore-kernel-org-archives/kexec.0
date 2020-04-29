Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v9 01/18] arm64: kexec: make dtb_mem always enabled
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-2-pasha.tatashin@soleen.com>
From: James Morse <james.morse@arm.com>
Message-ID: <f29c53ec-a152-a4a9-6d50-7aeedd60173f@arm.com>
Date: Wed, 29 Apr 2020 18:00:40 +0100
MIME-Version: 1.0
In-Reply-To: <20200326032420.27220-2-pasha.tatashin@soleen.com>
Content-Language: en-GB
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, corbet@lwn.net, catalin.marinas@arm.com, bhsharma@redhat.com, steve.capper@arm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, rfontana@redhat.com, ebiederm@xmission.com, maz@kernel.org, matthias.bgg@gmail.com, tglx@linutronix.de, will@kernel.org, selindag@gmail.com, linux-arm-kernel@lists.infradead.org

Hi Pavel,

On 26/03/2020 03:24, Pavel Tatashin wrote:
> Currently, dtb_mem is enabled only when CONFIG_KEXEC_FILE is
> enabled. This adds ugly ifdefs to c files.

~s/dtb_mem/ARCH_HAS_KIMAGE_ARCH/ ?
dtb_mem is just one member of struct kimage_arch.


> Always enabled dtb_mem, when it is not used, it is NULL.
> Change the dtb_mem to phys_addr_t, as it is a physical address.

Regardless,
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
