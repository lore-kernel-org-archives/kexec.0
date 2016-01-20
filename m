Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 20 Jan 2016 10:56:21 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 00/19] arm64 kexec kernel patches v13
Message-ID: <20160120025621.GC2999@dhcp-128-65.nay.redhat.com>
References: <cover.1452884156.git.geoff@infradead.org>
 <20160119123230.GB2904@dhcp-128-65.nay.redhat.com>
 <1453248900.21755.8.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1453248900.21755.8.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, christoffer.dall@linaro.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 01/19/16 at 04:15pm, Geoff Levand wrote:
> On Tue, 2016-01-19 at 20:32 +0800, Dave Young wrote:
> > Geoff, another question about kexec-tools part is, can the kexec
> > -tools code
> > been written in kernel? We have the infrastructure for kexec_file_load.
> 
> I see no technical reason why the arm64 kernel cannot support
> kexec_file_load.

Cool, care to port it to kernel so that we have kexec_file_load only in arm64
we do not need to support both kexec_load and kexec_file_load?

> 
> -Geoff
> 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
