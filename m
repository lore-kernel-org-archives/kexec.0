Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1429289988.5479.9.camel@infradead.org>
Subject: Re: [PATCH RFC 3/6] arm64: allocate memory for other segments after
 kernel
From: Geoff Levand <geoff@infradead.org>
Date: Fri, 17 Apr 2015 09:59:48 -0700
In-Reply-To: <1d852e11a3f121d5a3cfd86c05102e940e33944c.1429201849.git.panand@redhat.com>
References: <cover.1429201849.git.panand@redhat.com>
 <1d852e11a3f121d5a3cfd86c05102e940e33944c.1429201849.git.panand@redhat.com>
Mime-Version: 1.0
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
Cc: kexec@lists.infradead.org, kexec@lists.fedoraproject.org

On Thu, 2015-04-16 at 22:17 +0530, Pratyush Anand wrote:
> In case of KEXEC_ON_CRASH, load other segments after the addresses where
> kernel segments finish.
> 
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---
>  kexec/arch/arm64/crashdump-arm64.c | 3 ++-

This one should be folded into Takahiro's latest patches.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
