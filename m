From: Christoph Hellwig <hch@lst.de>
Date: Thu, 7 Apr 2022 07:38:27 +0200
Subject: [PATCH v2] mm/vmalloc: fix spinning drain_vmap_work after
 reading from /proc/vmcore
In-Reply-To: <52f819991051f9b865e9ce25605509bfdbacadcd.1649277321.git.osandov@fb.com>
References: <52f819991051f9b865e9ce25605509bfdbacadcd.1649277321.git.osandov@fb.com>
Message-ID: <20220407053827.GB13500@lst.de>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

