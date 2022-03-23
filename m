From: Simon Horman <horms@verge.net.au>
Date: Wed, 23 Mar 2022 15:20:46 +0100
Subject: [PATCH] kexec-tools: print error if kexec_file_load fails
In-Reply-To: <53ecedd5-df24-7a32-7fa0-2a4cf50619c3@suse.cz>
References: <20220316103305.174842-1-hbathini@linux.ibm.com>
 <53ecedd5-df24-7a32-7fa0-2a4cf50619c3@suse.cz>
Message-ID: <Yjssvi6slPBRfvHv@vergenet.net>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, Mar 16, 2022 at 12:56:03PM +0100, Petr Tesarik wrote:
> Hi Hari,
> 
> Dne 16. 03. 22 v 11:33 Hari Bathini napsal(a):
> > Commit 4f77da634035 ("kexec-tools: Fix kexec_file_load(2) error
> > handling") introduced EFALLBACK for scenarios where fallbacking back
> > to kexec_load syscall is likely to work and dropped printing error
> > message for these scenarios. But printing error message for other
> > failure scenarios was inadvertently dropped. Restore printing error
> > message for such cases.
> 
> Indeed, my commit removed the error messages on failure.
> 
> > 
> > Fixes: 4f77da634035 ("kexec-tools: Fix kexec_file_load(2) error handling")
> > Cc: Petr Tesarik <ptesarik@suse.com>
> > Reported-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> > Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
> > Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> 
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>

Thanks, applied.

