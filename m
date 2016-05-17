Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 17 May 2016 13:42:16 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v15 00/20] arm64 kexec kernel patches v15
Message-ID: <20160517054216.GA12543@dhcp-128-65.nay.redhat.com>
References: <cover.1457977401.git.geoff@infradead.org>
 <20160401015947.GA3835@dhcp-128-65.nay.redhat.com>
 <1459535954.20121.3.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1459535954.20121.3.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>, marc.zyngier@arm.com
Cc: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Marc, it has been discussed for long time, I think kdump code can be
logically splitted from this series so that we can get the kexec
done first? 

On 04/01/16 at 11:39am, Geoff Levand wrote:
> Hi,
> 
> On Fri, 2016-04-01 at 09:59 +0800, Dave Young wrote:
> > Geoff, for easier to review maybe you can send kexec patches first
> > then AKASHI Takahiro
> > can send the kdump patches as a standalone patchset?
> 
> Marc Zyngier specifically asked for an integrated set
> of patches for easier review.  I will keep it that way
> for now.
> 
> -Geoff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
