Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bKiT7-0007U7-5t
 for kexec@lists.infradead.org; Wed, 06 Jul 2016 08:46:05 +0000
Date: Wed, 6 Jul 2016 16:45:38 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] scripts: Fix size mismatch of kexec_purgatory_size
Message-ID: <20160706084538.GA11783@dhcp-128-65.nay.redhat.com>
References: <BE389624-FFFE-42F1-A89F-5E5598190D4A@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BE389624-FFFE-42F1-A89F-5E5598190D4A@amazon.com>
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
To: "Tautschnig, Michael" <tautschn@amazon.co.uk>
Cc: Michal Marek <mmarek@suse.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>, "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>

On 07/04/16 at 01:55pm, Tautschnig, Michael wrote:
> bin2c is used to create a valid C file out of a binary file where two
> symbols will be globally defined: <name> and <name>_size. <name> is
> passed as the first parameter of the host binary.
> 
> Building using goto-cc reported that the purgatory binary code (the only
> current user of this utility) declares kexec_purgatory_size as 'size_t'
> where bin2c generate <name>_size to be 'int' so in a 64-bit host where
> sizeof(size_t) > sizeof(int) this type mismatch will always yield the
> wrong value for big-endian architectures while for little-endian it will
> be wrong if the object laid in memory directly after
> kexec_purgatory_size contains non-zero value at the time of reading.
> 
> This commit changes <name>_size to be size_t instead.
> 
> Note:
> 
> Another way to fix the problem is to change the type of
> kexec_purgatory_size to be 'int' as there's this check in code:
> (kexec_purgatory_size <= 0)
> 
> Signed-off-by: Michael Tautschnig <tautschn@amazon.com>
> Cc: Michal Marek <mmarek@suse.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> ---
>  scripts/basic/bin2c.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/basic/bin2c.c b/scripts/basic/bin2c.c
> index af187e6..c3d7eef 100644
> --- a/scripts/basic/bin2c.c
> +++ b/scripts/basic/bin2c.c
> @@ -29,7 +29,8 @@ int main(int argc, char *argv[])
>  	} while (ch != EOF);
> 
>  	if (argc > 1)
> -		printf("\t;\n\nconst int %s_size = %d;\n", argv[1], total);
> +		printf("\t;\n\n#include <linux/types.h>\n\nconst size_t %s_size = %d;\n",
> +		       argv[1], total);
> 
>  	return 0;
>  }
> --
> 2.7.3.AMZN
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
