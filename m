From: Simon Horman <horms@verge.net.au>
Date: Thu, 24 Mar 2022 11:57:44 +0100
Subject: [PATCH] util_lib/elf_info: harden parsing of printk buffer
In-Reply-To: <20220323153536.8527-1-prudo@redhat.com>
References: <20220323153536.8527-1-prudo@redhat.com>
Message-ID: <YjxOqP8dSTmNPyku@vergenet.net>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, Mar 23, 2022 at 04:35:36PM +0100, Philipp Rudo wrote:
> The old printk mechanism (> v3.5.0 and < v5.10.0) had a fixed size
> buffer (log_buf) that contains all messages. The location for the next
> message is stored in log_next_idx. In case the log_buf runs full
> log_next_idx wraps around and starts overwriting old messages at the
> beginning of the buffer. The wraparound is denoted by a message with
> msg->len == 0.
> 
> Following the behavior described above blindly is dangerous as e.g. a
> memory corruption could overwrite (parts of) the log_buf. If the
> corruption adds a message with msg->len == 0 this leads to an endless
> loop when dumping the dmesg. Fix this by verifying that not wrapped
> around before when it encounters a message with msg->len == 0.
> 
> While at it also verify that the index is within the log_buf and thus
> guard against corruptions with msg->len != 0.
> 
> The same bug has been reported and fixed in makedumpfile [1].
> 
> [1] http://lists.infradead.org/pipermail/kexec/2022-March/024272.html
> 
> Signed-off-by: Philipp Rudo <prudo@redhat.com>

Thanks Philipp, applied.

