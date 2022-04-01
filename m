From: Simon Horman <horms@verge.net.au>
Date: Fri, 1 Apr 2022 16:00:42 +0200
Subject: [PATCH] arm64: fix static data relocations in
 machine_apply_elf_rel()
In-Reply-To: <20220331060331.13866-1-piliu@redhat.com>
References: <20220331060331.13866-1-piliu@redhat.com>
Message-ID: <YkcFisYB2dGi3XBh@vergenet.net>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Thu, Mar 31, 2022 at 02:03:31PM +0800, Pingfan Liu wrote:
> As for 'static data relocations', instead of patching an instruction (OR
> ops), it should be assigned to value directly.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Geoff Levand <geoff@infradead.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Simon Horman <horms@verge.net.au>
> To: kexec at lists.infradead.org

Thanks, applied.

