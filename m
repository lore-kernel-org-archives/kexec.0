Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 10 Dec 2015 17:20:18 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v12 12/16] arm64: kdump: implement machine_crash_shutdown()
Message-ID: <20151210115018.GA4695@dhcppc13.redhat.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <9ae67f7515c66bfd747486c8dc1c1772913a8d46.1448403503.git.geoff@infradead.org>
 <20151203041525.GG14143@dhcppc13.redhat.com>
 <56696514.3030209@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56696514.3030209@linaro.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org, msalter@redhat.com, kexec@lists.infradead.org, christoffer.dall@linaro.org

On 10/12/2015:08:42:12 PM, AKASHI Takahiro wrote:
> >>+ * machine_crash_shutdown - shutdown non-boot cpus and save registers
> >
> >"non-panic" would be correct in stead of "non-boot".
> 
> OK, but for consistency with other places (say, arm/kernel/machine_kexec.c)
> I prefer "non-crashing cpus."

OK.

> 
> >>+	/* shutdown non-boot cpus */
> >
> >Ditto
> >
> >>+	smp_send_stop();
> >>+
> >>+	/* for boot cpu */
> >
> >"for panic cpu"
> 
> Ditto.
> "for crashing cpu"

OK.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
