Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1467045860.7965.31.camel@infradead.org>
Subject: Re: [PATCH v20 01/14] arm64: hibernate: Don't hibernate on systems
 with stuck CPUs
From: Geoff Levand <geoff@infradead.org>
Date: Mon, 27 Jun 2016 09:44:20 -0700
In-Reply-To: <57710843.40806@arm.com>
References: <cover.1466702804.git.geoff@infradead.org>
 <97dcd35763eddf1b4c50a26d16389f313269f0c8.1466702804.git.geoff@infradead.org>
 <57710843.40806@arm.com>
Mime-Version: 1.0
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
To: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi,

On Mon, 2016-06-27 at 12:04 +0100, James Morse wrote:
> ... this patch isn't necessary for kexec, it wired up the helper
> function you
> have in patch 2 for hibernate.
> 
> Please drop this in any future posting!

It seems both your patches I had went in for -rc5, so
they're gone now from my master.

-Geoff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
