Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v9 09/18] arm64: kexec: call kexec_image_info only once
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-10-pasha.tatashin@soleen.com>
From: James Morse <james.morse@arm.com>
Message-ID: <61f1b270-9c88-f309-9665-0221a228b5b9@arm.com>
Date: Wed, 29 Apr 2020 18:01:33 +0100
MIME-Version: 1.0
In-Reply-To: <20200326032420.27220-10-pasha.tatashin@soleen.com>
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
> Currently, kexec_image_info() is called during load time, and
> right before kernel is being kexec'ed. There is no need to do both.

I think the original logic was if debugging, you'd see the load-time value in dmesg, and
the kexec-time values when the machine panic()d and you hadn't made a note of the previous
set. But I'm not sure why you'd have these debug messages enabled unless you were
debugging kexec.


> So, call it only once when segments are loaded and the physical
> location of page with copy of arm64_relocate_new_kernel is known.

Sure, keep the earlier version that is more likely to be seen.

Acked-by: James Morse <james.morse@arm.com>


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
