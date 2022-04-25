From: Luis Chamberlain <mcgrof@kernel.org>
Date: Mon, 25 Apr 2022 14:02:02 -0700
Subject: [PATCH sysctl-testing v2] kernel/kexec_core: move kexec_core
 sysctls into its own file
In-Reply-To: <20220424025740.50371-1-yingelin@huawei.com>
References: <20220424025740.50371-1-yingelin@huawei.com>
Message-ID: <YmcMSkI8ea/Ncz4y@bombadil.infradead.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Sun, Apr 24, 2022 at 10:57:40AM +0800, yingelin wrote:
> This move the kernel/kexec_core.c respective sysctls to its own file.
> 
> kernel/sysctl.c has grown to an insane mess, We move sysctls to places
> where features actually belong to improve the readability and reduce
> merge conflicts. At the same time, the proc-sysctl maintainers can easily
> care about the core logic other than the sysctl knobs added for some feature.
> 
> We already moved all filesystem sysctls out. This patch is part of the effort
> to move kexec related sysctls out.
> 
> Signed-off-by: yingelin <yingelin@huawei.com>

Thanks! Queued onto sysctl-testing.

  Luis

