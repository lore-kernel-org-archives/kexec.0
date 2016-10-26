Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH] arm64: Add support of R_AARCH64_PREL32 relocation in
 purgatory
References: <0eb8a908f617e0f957df7fb3ef293596f47e6832.1477456661.git.panand@redhat.com>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <34a7177f-3bd8-8ccf-f928-36f89e9e29f2@infradead.org>
Date: Wed, 26 Oct 2016 12:57:52 -0700
MIME-Version: 1.0
In-Reply-To: <0eb8a908f617e0f957df7fb3ef293596f47e6832.1477456661.git.panand@redhat.com>
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
Cc: catalin.marinas@arm.com, horms@verge.net.au, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 10/25/2016 09:40 PM, Pratyush Anand wrote:
> +	case R_AARCH64_PREL32:
> +		type = "PREL32";
> +		loc32 = ptr;
> +		*loc32 = cpu_to_elf32(ehdr, elf32_to_cpu(ehdr, *loc32) + value - address);

Please keep line width less than 80 chars.

> +		break;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
