Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 5 Dec 2019 16:30:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v4 7/8] linux/log2.h: Fix 64bit calculations in
 roundup/down_pow_two()
Message-ID: <20191205223044.GA250573@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191203114743.1294-8-nsaenzjulienne@suse.de>
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
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: linux-pci@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>, "J. Bruce Fields" <bfields@fieldses.org>, linux-nfs@vger.kernel.org, Edward Cree <ecree@solarflare.com>, linux-clk@vger.kernel.org, f.fainelli@gmail.com, Herbert Xu <herbert@gondor.apana.org.au>, Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, maz@kernel.org, Joerg Roedel <joro@8bytes.org>, phil@raspberrypi.org, Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, Chen-Yu Tsai <wens@csie.org>, Chuck Lever <chuck.lever@oracle.com>, Martin Habets <mhabets@solarflare.com>, wahrenst@gmx.net, Tom Lendacky <thomas.lendacky@amd.com>, Jiri Pirko <jiri@resnulli.us>, Solarflare linux maintainers <linux-net-drivers@solarflare.com>, Maxime Ripard <mripard@kernel.org>, linux-rpi-kernel@lists.infradead.org, Anna Schumaker <anna.schumaker@netapp.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, linux-arm-kernel@lists.infradead.org, Mirko Lindner <mlindner@marvell.com>, Mike Marciniszyn <mike.marciniszyn@intel.com>, mbrugger@suse.com, Stephen Boyd <sboyd@kernel.org>, netdev@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jeremy.linton@arm.com, "David S. Miller" <davem@davemloft.net>, Stephen Hemminger <stephen@networkplumber.org>, linux-rdma@vger.kernel.org, iommu@lists.linux-foundation.org, Moni Shoua <monis@mellanox.com>, Eric Biederman <ebiederm@xmission.com>, james.quinlan@broadcom.com, Thomas Graf <tgraf@suug.ch>, andrew.murray@arm.com, Robin Murphy <robin.murphy@arm.con>, David Woodhouse <dwmw2@infradead.org>, Dennis Dalessandro <dennis.dalessandro@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>

You got the "n" on "down" in the subject, but still missing "of" ;)

On Tue, Dec 03, 2019 at 12:47:40PM +0100, Nicolas Saenz Julienne wrote:
> Some users need to make sure their rounding function accepts and returns
> 64bit long variables regardless of the architecture. Sadly
> roundup/rounddown_pow_two() takes and returns unsigned longs. It turns
> out ilog2() already handles 32/64bit calculations properly, and being
> the building block to the round functions we can rework them as a
> wrapper around it.

Missing "of" in the function names here.
s/a wrapper/wrappers/

IIUC the point of this is that roundup_pow_of_two() returned
"unsigned long", which can be either 32 or 64 bits (worth pointing
out, I think), and many callers need something that returns
"unsigned long long" (always 64 bits).

It's a nice simplification to remove the "__" variants.  Just as a
casual reader of this commit message, I'd like to know why we had both
the roundup and the __roundup versions in the first place, and why we
no longer need both.

> -#define roundup_pow_of_two(n)			\
> -(						\
> -	__builtin_constant_p(n) ? (		\
> -		(n == 1) ? 1 :			\
> -		(1UL << (ilog2((n) - 1) + 1))	\
> -				   ) :		\
> -	__roundup_pow_of_two(n)			\
> - )
> +#define roundup_pow_of_two(n)			  \
> +(						  \
> +	(__builtin_constant_p(n) && ((n) == 1)) ? \
> +	1 : (1ULL << (ilog2((n) - 1) + 1))        \
> +)

Should the resulting type of this expression always be a ULL, even
when n==1, i.e., should it be this?

  1ULL : (1ULL << (ilog2((n) - 1) + 1))        \

Or maybe there's no case where that makes a difference?

Bjorn

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
