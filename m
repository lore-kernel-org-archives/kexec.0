From: Simon Horman <horms@verge.net.au>
Date: Thu, 24 Mar 2022 11:56:44 +0100
Subject: [PATCH kexec-tools] github: run apt-get update before installing
 packages
In-Reply-To: <20220323140220.358948-1-horms@verge.net.au>
References: <20220323140220.358948-1-horms@verge.net.au>
Message-ID: <YjxObLOJWjB3SxGE@vergenet.net>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, Mar 23, 2022 at 03:02:20PM +0100, Simon Horman wrote:
> Refresh package database before installing dependencies to avoid failures
> due to trying to install older, no longer available, versions of packages.
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>

Applied.

