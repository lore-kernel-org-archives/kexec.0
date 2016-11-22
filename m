Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH 2/2] arm64: Pass RAM boundary and enable-dcache flag to
 purgatory
References: <cover.1479788404.git.panand@redhat.com>
 <b1b9e70db9d08364040436154cf0cf2f4600da49.1479788404.git.panand@redhat.com>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <53ee2a62-7822-5457-e59f-e65e64a57019@infradead.org>
Date: Tue, 22 Nov 2016 10:57:10 -0800
MIME-Version: 1.0
In-Reply-To: <b1b9e70db9d08364040436154cf0cf2f4600da49.1479788404.git.panand@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>, kexec@lists.infradead.org
Cc: james.morse@arm.com, linux-arm-kernel@lists.infradead.org

Hi Pratyush,

On 11/21/2016 08:32 PM, Pratyush Anand wrote:
> When "enable-dcache" is passed to the kexec() command line, kexec-tools
> passes this information to purgatory, which in turn enables cache during
> sha-256 verification.

What's the point of this enable-dcache option?  Why not just
always enable the cache if we can?

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
