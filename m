Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fFXwg-00051F-6x
 for kexec@lists.infradead.org; Mon, 07 May 2018 04:40:19 +0000
Received: by mail-pg0-x234.google.com with SMTP id p9-v6so16426116pgc.9
 for <kexec@lists.infradead.org>; Sun, 06 May 2018 21:40:06 -0700 (PDT)
Date: Mon, 7 May 2018 13:40:51 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v9 02/11] kexec_file: make
 kexec_image_post_load_cleanup_default() global
Message-ID: <20180507044050.GC11326@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-3-takahiro.akashi@linaro.org>
 <cbf66675-1671-32f9-1410-a76986becf85@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cbf66675-1671-32f9-1410-a76986becf85@arm.com>
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
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

On Tue, May 01, 2018 at 06:46:04PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 25/04/18 07:26, AKASHI Takahiro wrote:
> > Change this function from static to global so that arm64 can implement
> > its own arch_kimage_file_post_load_cleanup() later using
> > kexec_image_post_load_cleanup_default().
> 
> Do we need to call kexec_image_post_load_cleanup_default()? All it does is call
> the image-type fops->cleanup(), which you don't implement in this series.
> 
> Is this just-in-case someone adds cleanup() later and is surprised only the
> arch-level helper is called?

Yes, we want not to miss two possibilities:
- some common clean-up code is added to kexec_image_post_load_cleanup_default()
- some format(i.e. Image)-specific clean-up code is added to fops->cleanup()

-Takahiro AKASHI

> 
> 
> Thanks,
> 
> James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
