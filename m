Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 15 Jul 2016 13:13:44 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] arm: plug a zImage corner case
Message-ID: <20160715041343.GC28151@verge.net.au>
References: <20160707102003.GO1041@n2100.armlinux.org.uk>
 <E1bL9rj-0002Ow-6i@e0050434b2927.dyn.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1bL9rj-0002Ow-6i@e0050434b2927.dyn.armlinux.org.uk>
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
To: Russell King <rmk@armlinux.org.uk>
Cc: Pratyush Anand <panand@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>, Kees Cook <keescook@google.com>

On Thu, Jul 07, 2016 at 03:01:19PM +0100, Russell King wrote:
> If a zImage is built with ARM_APPENDED_DTB enabled, the zImage will
> look at the word following the zImage and check whether it contains
> the DTB magic number.
> 
> Generally, kexec will clear the destination pages before copying the
> zImage, but there is a corner case where the zImage is a multiple of
> the page size, where the following page will not be touched.  Should
> the first word in this page contain the DTB magic number, the data
> following will be interpreted as a DTB image.
> 
> In order to make this bullet-proof, we must always initialise the word
> following the zImage.  Arrange this by specifying the zImage memory
> size one word bigger than the buffer size.
> 
> Signed-off-by: Russell King <rmk@armlinux.org.uk>

Thanks, I have applied this and the next patch.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
