Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Date: Sat, 19 Oct 2013 17:13:14 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2] ARM: head-common.S: relocate atags area if necessary
Message-ID: <20131019161314.GK25034@n2100.arm.linux.org.uk>
References: <1382112776-20300-1-git-send-email-zonque@gmail.com>
 <20131018162956.GE25034@n2100.arm.linux.org.uk> <52616B56.10407@gmail.com>
 <20131018175414.GF25034@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1310191059290.1951@syhkavp.arg> <5262AEE8.5010505@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5262AEE8.5010505@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Daniel Mack <zonque@gmail.com>
Cc: kexec@lists.infradead.org, neumann@teufel.de, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>

On Sat, Oct 19, 2013 at 06:10:16PM +0200, Daniel Mack wrote:
> Well, I totally see your point. However, we have machines out there that
> won't update via kexec due to this, and fixing kexec is unfortunately
> not an option, as updating anything would involve kexec'ing into an
> update kernel again. So out only chance is to fix up the dtb location in
> early boot code.
> 
> You might say my case is special, and you're most probably right. I see
> that trying to fix things is opening a can of worms.
> 
> So - no worries, we'll just keep that patch around locally as it 'works
> for me' (tm) :)

How about fixing kexec to work properly anyway, so that at a later date
you can drop that patch?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
