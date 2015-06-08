Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z1oDK-0003MF-0f
 for kexec@lists.infradead.org; Mon, 08 Jun 2015 03:59:07 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t583v84c003780
 for <kexec@lists.infradead.org>; Mon, 8 Jun 2015 11:57:08 +0800
Message-ID: <5575123D.8090506@cn.fujitsu.com>
Date: Mon, 8 Jun 2015 11:55:41 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 00/11] makedumpfile: parallel processing
References: <1433491025-7291-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1433491025-7291-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

hello all,

I test this patch set in two machines and the following is the benchmark.

These tables show the time that makedumpfile spends. And the unit is second.

"core-data" in the table means the context in the vmcore.
	For example:
	core-data's value is 256. It means that in the vmcore, 256 * 8 bits of each page
	are set to 1.

"-l" in the table means producing lzo format vmcore

"-c" in the table means producing kdump-compressed format vmcore

###################################machine with 128G memory

************ makedumpfile -d 0 ******************
		core-data	256	1280
	threads_num
-l
	0			758	881	
	8			932	1014
	16			973	1085
-c
	0			3994	4071
	8			966	1007
	16			1053	1192

************ makedumpfile -d 3 ******************
		core-data	256	1280
	threads_num
-l
	0			764	847
	8			948	1058
	16			943	1069
-c
	0			4021	4050
	8			949	1029
	16			1051	1190

************ makedumpfile -d 31 ******************
		core-data	256	1280
	threads_num
-l
	0			4	4
	8			639	610
	16			680	680
-c
	0			14	13
	8			607	610
	16			631	662

###################################machine with 24G memory

************ makedumpfile -d 0 ******************
		core-data	0	256	512	768	1024	1280	1536	1792	2048	2304	2560	2816	3072	3328	3584	3840	4096
	threads_num	
-l	
	0			15	140	186	196	196	196	196	197	197	197	195	195	195	195	186	131	15
	4			9	136	189	204	204	202	201	200	201	200	200	202	204	203	189	136	9
	8			11	131	193	198	198	202	206	205	206	205	205	202	198	197	193	132	11
	12			18	137	194	202	203	197	201	203	204	202	201	196	202	202	194	136	17
-c	
	0			80	786	967	1031	874	849	700	608	652	603	764	768	873	1031	1016	776	80
	4			82	262	315	321	296	256	255	220	218	221	241	268	303	320	319	259	84
	8			58	148	174	189	179	189	196	198	199	198	196	190	178	174	170	145	57
	12			56	112	131	157	170	189	200	204	204	203	199	191	170	157	132	111	59

************ makedumpfile -d 1 ******************
		core-data	0	256	512	768	1024	1280	1536	1792	2048	2304	2560	2816	3072	3328	3584	3840	4096
	threads_num	
-l	
	0			16	134	194	204	204	205	205	206	205	207	204	203	204	204	193	134	15
	4			9	132	193	197	196	198	199	200	200	200	199	197	196	197	192	132	9
	8			12	135	189	202	204	200	197	196	197	195	196	199	203	202	189	136	12
	12			16	130	190	200	200	205	202	201	200	201	202	205	199	200	189	131	17
-c	
	0			77	775	1009	1032	872	853	699	606	643	602	758	765	870	1026	1014	774	78
	4			80	262	316	322	332	257	247	217	223	218	288	256	322	322	315	258	81
	8			56	146	173	176	170	184	198	205	207	203	198	185	169	180	169	149	56
	12			56	110	133	152	175	185	194	202	202	202	193	184	176	152	135	114	56

************ makedumpfile -d 7 ******************
		core-data	0	256	512	768	1024	1280	1536	1792	2048	2304	2560	2816	3072	3328	3584	3840	4096
	threads_num	
-l	
	0			16	138	188	197	197	197	197	197	197	198	196	197	197	197	189	137	16
	4			10	131	187	202	205	203	202	202	203	203	201	203	204	201	187	131	8
	8			11	135	191	199	197	201	203	205	206	204	203	200	197	199	192	134	11
	12			18	134	195	201	203	197	199	202	202	201	199	196	203	201	197	134	19
-c	
	0			77	770	1011	1032	871	841	698	621	645	601	763	765	870	1025	1014	773	78
	4			81	263	311	320	319	255	240	216	242	214	240	257	300	319	314	255	80
	8			57	157	176	172	174	191	196	199	199	199	195	191	173	171	167	146	57
	12			55	111	136	156	170	188	203	204	204	203	201	186	168	156	136	112	56

************ makedumpfile -d 31 ******************
		core-data	0	256	512	768	1024	1280	1536	1792	2048	2304	2560	2816	3072	3328	3584	3840	4096
	threads_num	
-l	
	0			1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1
	4			7	8	8	8	8	8	8	8	8	8	8	8	8	8	7	8	8
	8			11	11	11	10	11	11	11	11	11	11	10	11	11	11	11	11	11
	12			14	13	14	13	13	15	15	13	15	13	14	14	13	15	15	15	16
-c	
	0			4	4	5	4	4	4	4	4	4	4	4	4	4	4	4	4	4
	4			10	10	10	10	10	10	10	10	10	10	10	10	10	10	10	10	10
	8			12	12	12	13	12	12	12	12	12	12	13	12	14	13	12	12	13
	12			14	16	14	14	13	15	15	15	14	14	14	14	16	14	15	15	14


On 06/05/2015 03:56 PM, Zhou Wenjian wrote:
> This patch set implements parallel processing by means of multiple threads.
> With this patch set, it is available to use multiple threads to read
> and compress pages. This parallel process will save time.
> This feature only supports creating dumpfile in kdump-compressed format from
> vmcore in kdump-compressed format or elf format. Currently, sadump and
>   xen kdump are not supported.
>
> Qiao Nuohan (11):
>    Add readpage_kdump_compressed_parallel
>    Add mappage_elf_parallel
>    Add readpage_elf_parallel
>    Add read_pfn_parallel
>    Add function to initial bitmap for parallel use
>    Add filter_data_buffer_parallel
>    Add write_kdump_pages_parallel to allow parallel process
>    Add write_kdump_pages_parallel_cyclic to allow parallel process in
>      cyclic_mode
>    Initial and free data used for parallel process
>    Make makedumpfile available to read and compress pages parallelly
>    Add usage and manual about multiple threads process
>
>   Makefile       |    2 +
>   erase_info.c   |   29 +-
>   erase_info.h   |    2 +
>   makedumpfile.8 |   24 +
>   makedumpfile.c | 1505 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   makedumpfile.h |   79 +++
>   print_info.c   |   16 +
>   7 files changed, 1652 insertions(+), 5 deletions(-)
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


-- 
Thanks
Zhou Wenjian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
