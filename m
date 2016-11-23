Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 23 Nov 2016 09:08:19 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] arm64: Pass RAM boundary and enable-dcache flag to
 purgatory
Message-ID: <20161123080816.GA30255@verge.net.au>
References: <cover.1479788404.git.panand@redhat.com>
 <b1b9e70db9d08364040436154cf0cf2f4600da49.1479788404.git.panand@redhat.com>
 <53ee2a62-7822-5457-e59f-e65e64a57019@infradead.org>
 <54cad725-90f0-8dfe-bee6-fe1d3e02175d@redhat.com>
 <20161123020300.GA3481@dhcp-128-65.nay.redhat.com>
 <81975e6e-b97a-0401-0e18-b2d26722c1dd@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <81975e6e-b97a-0401-0e18-b2d26722c1dd@redhat.com>
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
Cc: Geoff Levand <geoff@infradead.org>, james.morse@arm.com, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Wed, Nov 23, 2016 at 07:41:52AM +0530, Pratyush Anand wrote:
> 
> 
> On Wednesday 23 November 2016 07:33 AM, Dave Young wrote:
> >>Although this is very unlikely that a hardware will support only 16K page
> >>> sizes, however it is possible. Therefore, its better to keep it disabled by
> >>> default.
> >If it is *unlikely* it could be better to make it as default and add a
> >--disable-dcache instead.
> >
> 
> I think, I can do that.

Can this be detected at run-time?

It sounds like it will be painful if on some setups the default
doesn't work.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
