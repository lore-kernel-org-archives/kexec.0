Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZrkYK-0000K0-J4
 for kexec@lists.infradead.org; Thu, 29 Oct 2015 10:35:29 +0000
Date: Thu, 29 Oct 2015 16:05:04 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH V2 11/11] arm64: wait for transmit completion before next
 character transmission
Message-ID: <20151029103504.GB5387@dhcppc13.redhat.com>
References: <cover.1431582203.git.panand@redhat.com>
 <51d1170ea05f86a1ed7bf42f384c600e98447b7a.1431582203.git.panand@redhat.com>
 <1445293795.30908.50.camel@infradead.org>
 <20151020024153.GA31893@dhcppc13.redhat.com>
 <1445360694.30908.58.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1445360694.30908.58.camel@infradead.org>
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
Cc: takahiro.akashi@linaro.org, kexec@lists.infradead.org

Hi Geoff,

On 20/10/2015:10:04:54 AM, Geoff Levand wrote:
> Hi,
> 
> On Tue, 2015-10-20 at 08:11 +0530, Pratyush Anand wrote:
> > On 19/10/2015:03:29:55 PM, Geoff Levand wrote:
> > I tested this on the foundation model and it hangs.
> > 
> > Thanks for testing it.
> > 
> > Which uart model has been used in foundation model?
> 
> I only tested it, but did not look into it.  The
> documentation should be on the ARM developer's site.

Line status register offset for pl011(which is in foundation model) and 8250
based uart are not same. I think, in that case we should keep separate argument
for lsr. Can you please try patch[1] and let me know your feedback.

If you are using UART0 of foundation model, then you would be passing
--port=0x1C090000. With patch[1], you may pass one more argument
--port-lsr=0x1C090018,0x80. Even if --port-lsr is not passed to kexec() system
call, it will not hang. However, one may not see all the printed character
without --port-lsr.

~Pratyush

[1] https://github.com/pratyushanand/kexec-tools/commit/57344a8516447cefabc2372daf9a6b0b04bd9851

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
