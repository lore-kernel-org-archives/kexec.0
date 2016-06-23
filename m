Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 23 Jun 2016 09:41:35 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/2] Simple fix to the ARM kexec tools implementation
Message-ID: <20160623004135.GB9412@verge.net.au>
References: <20160617194405.GN1041@n2100.armlinux.org.uk>
 <20160621061128.GC29309@dhcppc9>
 <20160621082033.GS1041@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160621082033.GS1041@n2100.armlinux.org.uk>
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
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Pratyush Anand <panand@redhat.com>, kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>, linux-arm-kernel@lists.infradead.org, Kees Cook <keescook@google.com>

On Tue, Jun 21, 2016 at 09:20:33AM +0100, Russell King - ARM Linux wrote:
> On Tue, Jun 21, 2016 at 11:41:28AM +0530, Pratyush Anand wrote:
> > Yes, so until we have proper header for zImage, these patches looks
> > fine to me.
> 
> If you read my last email in the "kexec failures with DEBUG_RODATA"
> thread, you'll see that I'm unhappy with this idea, because adding a
> "proper header" still results in some kind of assumption about how
> the zImage decompressor works being needed by the boot environment.
> 
> > For both of the patches:
> > 
> > Reviewed-by: Pratyush Anand <panand@redhat.com>
> 
> Thanks.
> 
> Simon, do you need me to resend with the r-b tag, or will you pick
> these two up and the documentation fix patch you asked for?

Thanks for reminding me about this, I have applied this patch
and the other one you mention.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
