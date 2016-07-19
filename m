Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <c4af21ba365767f88a2516719dd0f3b70777b549.1468970114.git.geoff@infradead.org>
In-Reply-To: <cover.1468970114.git.geoff@infradead.org>
References: <cover.1468970114.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH v1 1/4] kexec: (bugfix) calc correct end address of memory
 ranges in device tree
Date: Tue, 19 Jul 2016 23:28:13 +0000
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Pratyush Anand <panand@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

The end address of "reg" attribute in device tree's memory should be
inclusive.

From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 kexec/fs2dt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
index 6ed2399..f00fd98 100644
--- a/kexec/fs2dt.c
+++ b/kexec/fs2dt.c
@@ -236,7 +236,8 @@ static void add_dyn_reconf_usable_mem_property__(int fd)
 						    ranges_size*8);
 				}
 				ranges[rlen++] = cpu_to_be64(loc_base);
-				ranges[rlen++] = cpu_to_be64(loc_end - loc_base);
+				ranges[rlen++] = cpu_to_be64(loc_end
+								- loc_base + 1);
 				rngs_cnt++;
 			}
 		}
@@ -350,7 +351,7 @@ static void add_usable_mem_property(int fd, size_t len)
 					    ranges_size*sizeof(*ranges));
 			}
 			ranges[rlen++] = cpu_to_be64(loc_base);
-			ranges[rlen++] = cpu_to_be64(loc_end - loc_base);
+			ranges[rlen++] = cpu_to_be64(loc_end - loc_base + 1);
 		}
 	}
 
-- 
2.5.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
