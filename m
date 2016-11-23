Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 23 Nov 2016 10:03:00 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 2/2] arm64: Pass RAM boundary and enable-dcache flag to
 purgatory
Message-ID: <20161123020300.GA3481@dhcp-128-65.nay.redhat.com>
References: <cover.1479788404.git.panand@redhat.com>
 <b1b9e70db9d08364040436154cf0cf2f4600da49.1479788404.git.panand@redhat.com>
 <53ee2a62-7822-5457-e59f-e65e64a57019@infradead.org>
 <54cad725-90f0-8dfe-bee6-fe1d3e02175d@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54cad725-90f0-8dfe-bee6-fe1d3e02175d@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: Geoff Levand <geoff@infradead.org>, james.morse@arm.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 11/23/16 at 07:16am, Pratyush Anand wrote:
> Hi Geoff,
> 
> On Wednesday 23 November 2016 12:27 AM, Geoff Levand wrote:
> > Hi Pratyush,
> > 
> > On 11/21/2016 08:32 PM, Pratyush Anand wrote:
> > > When "enable-dcache" is passed to the kexec() command line, kexec-tools
> > > passes this information to purgatory, which in turn enables cache during
> > > sha-256 verification.
> > 
> > What's the point of this enable-dcache option?  Why not just
> > always enable the cache if we can?
> 
> As I have written in changelog of patch 1/2
> 
> "We are supporting only 4K and 64K page sizes. This code will not work if a
> hardware is not supporting at least one of these page sizes.  Therefore,
> D-cache is disabled by default and enabled only when "enable-dcache" is
> passed to the kexec()."
> 
> 
> Although this is very unlikely that a hardware will support only 16K page
> sizes, however it is possible. Therefore, its better to keep it disabled by
> default.

If it is *unlikely* it could be better to make it as default and add a
--disable-dcache instead.

> 
> ~Pratyush
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
