From: Simon Horman <horms@verge.net.au>
Date: Wed, 30 Mar 2022 19:35:48 +0200
Subject: [PATCH] kexec-tools: fix leak FILE pointer.
In-Reply-To: <20220330110951.3261355-1-lichliu@redhat.com>
References: <20220330110951.3261355-1-lichliu@redhat.com>
Message-ID: <YkSU9N0yarDcwQH2@vergenet.net>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, Mar 30, 2022 at 07:09:51PM +0800, Lichen Liu wrote:
> Close fp if file size is smaller than 13 bytes.
> 
> Signed-off-by: Lichen Liu <lichliu@redhat.com>

Thanks, applied.

