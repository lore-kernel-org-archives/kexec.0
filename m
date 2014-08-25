Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XLyTg-0007f9-IO
 for kexec@lists.infradead.org; Mon, 25 Aug 2014 17:54:48 +0000
Date: Mon, 25 Aug 2014 13:54:00 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 4/5] kexec: Add IND_FLAGS macro
Message-ID: <20140825175400.GG14379@redhat.com>
References: <cover.1408731991.git.geoff@infradead.org>
 <c2d710e956591376b08bcbc3f904efd9b0c8b912.1408731991.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c2d710e956591376b08bcbc3f904efd9b0c8b912.1408731991.git.geoff@infradead.org>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org

On Fri, Aug 22, 2014 at 06:39:47PM +0000, Geoff Levand wrote:
> Add a new kexec preprocessor macro IND_FLAGS, which is the bitwise OR of
> all the possible kexec IND_ kimage_entry indirection flags.
> 
> Having this macro allows for simplified code in the prosessing of the
> kexec kimage_entry items.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
>  include/linux/kexec.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 8c628ca..a4758f9 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -10,6 +10,7 @@
>  #define IND_INDIRECTION  (1 << IND_INDIRECTION_BIT)
>  #define IND_DONE         (1 << IND_DONE_BIT)
>  #define IND_SOURCE       (1 << IND_SOURCE_BIT)
> +#define IND_FLAGS (IND_DESTINATION | IND_INDIRECTION | IND_DONE | IND_SOURCE)
>  
>  #if !defined(__ASSEMBLY__)
>  
> -- 
> 1.9.1
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
