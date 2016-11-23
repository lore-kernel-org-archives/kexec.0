Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c9MeC-0001jS-Pl
 for kexec@lists.infradead.org; Wed, 23 Nov 2016 01:46:53 +0000
Received: by mail-qk0-f180.google.com with SMTP id x190so49853358qkb.0
 for <kexec@lists.infradead.org>; Tue, 22 Nov 2016 17:46:32 -0800 (PST)
Subject: Re: [PATCH 2/2] arm64: Pass RAM boundary and enable-dcache flag to
 purgatory
References: <cover.1479788404.git.panand@redhat.com>
 <b1b9e70db9d08364040436154cf0cf2f4600da49.1479788404.git.panand@redhat.com>
 <53ee2a62-7822-5457-e59f-e65e64a57019@infradead.org>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <54cad725-90f0-8dfe-bee6-fe1d3e02175d@redhat.com>
Date: Wed, 23 Nov 2016 07:16:26 +0530
MIME-Version: 1.0
In-Reply-To: <53ee2a62-7822-5457-e59f-e65e64a57019@infradead.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoff@infradead.org>, kexec@lists.infradead.org
Cc: james.morse@arm.com, linux-arm-kernel@lists.infradead.org

Hi Geoff,

On Wednesday 23 November 2016 12:27 AM, Geoff Levand wrote:
> Hi Pratyush,
>
> On 11/21/2016 08:32 PM, Pratyush Anand wrote:
>> When "enable-dcache" is passed to the kexec() command line, kexec-tools
>> passes this information to purgatory, which in turn enables cache during
>> sha-256 verification.
>
> What's the point of this enable-dcache option?  Why not just
> always enable the cache if we can?

As I have written in changelog of patch 1/2

"We are supporting only 4K and 64K page sizes. This code will not work if a
hardware is not supporting at least one of these page sizes.  Therefore,
D-cache is disabled by default and enabled only when "enable-dcache" is
passed to the kexec()."


Although this is very unlikely that a hardware will support only 16K 
page sizes, however it is possible. Therefore, its better to keep it 
disabled by default.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
