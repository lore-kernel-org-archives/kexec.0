From: Simon Horman <horms@verge.net.au>
Date: Fri, 14 Jan 2022 16:05:06 +0100
Subject: [PATCH v3 0/5] s390: add support for extended cmdline length
In-Reply-To: <20211216114356.605851-1-svens@linux.ibm.com>
References: <20211216114356.605851-1-svens@linux.ibm.com>
Message-ID: <20220114150506.GI16732@vergenet.net>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu, Dec 16, 2021 at 12:43:51PM +0100, Sven Schnelle wrote:
> Hi,
> 
> this patchset adds support for extended command line lengths on s390.
> The former limit of 896 has been too short in a some configurations. The
> linux kernel now provides an additional field in the parameter area
> which contains the maximum allowed command line length. In older kernels
> this field is zero. In that case the old limit of 896 bytes is used.
> This was introduced with 5ecb2da660ab ("s390: support command lines
> longer than 896 bytes") in linux.
> 
> And while at it, also add the --reuse-cmdline option and use
> KEXEC_ALL_OPTIONS.
> 
> Changes in v3:
> - handle short reads and interruptions in slurp_proc_file()
> 
> Changes in v2:
> 
> - add slurp_proc_file() to read proc files without knowing the size upfront
> - move command_line string from global to function scope

Thanks, applied.

