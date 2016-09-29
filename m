Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 29 Sep 2016 09:40:00 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v6 0/3] arm64 kexec-tools patches
Message-ID: <20160929074000.GB14497@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f1331028-e20b-50a3-fdeb-1e24861c7f29@suse.com>
 <20160923085840.GA22928@localhost.localdomain>
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
To: Pratyush Anand <panand@redhat.com>, Matthias Brugger <mbrugger@suse.com>
Cc: Geoff Levand <geoff@infradead.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Mark Rutland <mark.rutland@arm.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Wed, Sep 28, 2016 at 06:05:14PM +0200, Matthias Brugger wrote:
> 
> 
> On 21/09/16 20:14, Geoff Levand wrote:
> >This series adds the core support for kexec re-boot on ARM64.
> >
> 
> I also tested on seattle.
> 
> Tested-By: Matthias Brugger <mbrugger@suse.com>

On Fri, Sep 23, 2016 at 02:28:40PM +0530, Pratyush Anand wrote:
> Hi Geoff,
> 
> On 21/09/2016:06:14:25 PM, Geoff Levand wrote:
> > This series adds the core support for kexec re-boot on ARM64.
> 
> I tested this series with mustang and seattle and they work.
> 
> So you can use my "Tested-By: Pratyush Anand <panand@redhat.com>".
> 
> Just one Nitpick: In patch 2/3 arm64_header_check_msb(),
> arm64_header_page_size() and arm64_header_placement() have been defined but they
> have not been used anywhere. So, may be they can be removed.

Thanks everyone, I have queued this up with the above tags.

Please consider a follow-up patch to remove the functions mentioned above.

FWIW I tested v5 of this patchset on Renesas Gen3 R-Car H3 and M3-W and
it seems to work fine.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
