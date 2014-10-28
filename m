Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xj1FL-0002OD-39
 for kexec@lists.infradead.org; Tue, 28 Oct 2014 07:31:17 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v2 5/5] Add support for --splitblock-size
Date: Tue, 28 Oct 2014 07:28:47 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D5927F@BPXM01GP.gisp.nec.co.jp>
References: <1413192866-28140-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1413192866-28140-6-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <20141028.161513.171850531.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20141028.161513.171850531.d.hatayama@jp.fujitsu.com>
Content-Language: ja-JP
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "zhouwj-fnst@cn.fujitsu.com" <zhouwj-fnst@cn.fujitsu.com>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>> Use --splitblock-size to specify splitblock size (KB)
>> When --split is specified in cyclic mode,splitblock table will be
>> generated in create_dump_bitmap().
>>
>> Signed-off-by: Qiao Nuohan <qiaonuohan@cn.fujitsu.com>
>> Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
>> ---
>>  makedumpfile.8 |   16 ++++++++++++++++
>>  makedumpfile.c |    4 ++++
>>  makedumpfile.h |    1 +
>>  print_info.c   |   16 +++++++++++++++-
>>  4 files changed, 36 insertions(+), 1 deletions(-)
>>
>> diff --git a/makedumpfile.8 b/makedumpfile.8
>> index 9cb12c0..a5b7055 100644
>> --- a/makedumpfile.8
>> +++ b/makedumpfile.8
>> @@ -386,6 +386,22 @@ size, so ordinary users don't need to specify this option.
>>  # makedumpfile \-\-cyclic\-buffer 1024 \-d 31 \-x vmlinux /proc/vmcore dumpfile
>>
>>  .TP
>> +\fB\-\-splitblock\-size\fR \fIsplitblock_size\fR
>> +Specify the splitblock size in kilo bytes for analysis in the cyclic mode with --split.
>> +In the cyclic split mode, the number of splitblocks is represented as:
>> +
>> +    num_of_splitblocks = system_memory / (\fIsplitblock_size\fR * 1KB )
>> +
>
>For what people do you want to show this expression? It would be hard
>for ordinary users to understand this expression. I think at least the
>following explanation is necessary; and more detailed information is
>verbose.
>
>  If --splitblock N is specified, difference of each splitted dumpfile
>  size is at most N kilo bytes.
>
>> +The larger number of splitblock, the faster working speed is expected, but the more memory will
>> +be taken. By default, \fIsplitblock_size\fR will be set as 1GB, so ordinary users don't need to
>> +specify this option.
>> +
>> +.br
>> +.B Example:
>> +.br
>> +# makedumpfile \-\-splitblock\-size 10240 \-d 31 \-x vmlinux \-\-split /proc/vmcore dumpfile1 dumpfile2
>> +
>> +.TP
>>  \fB\-\-non\-cyclic\fR
>>  Running in the non-cyclic mode, this mode uses the old filtering logic same as v1.4.4 or before.
>>  If you feel the cyclic mode is too slow, please try this mode.
>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index 32c0919..112f2e4 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -9578,6 +9578,7 @@ static struct option longopts[] = {
>>  	{"eppic", required_argument, NULL, OPT_EPPIC},
>>  	{"non-mmap", no_argument, NULL, OPT_NON_MMAP},
>>  	{"mem-usage", no_argument, NULL, OPT_MEM_USAGE},
>> +	{"splitblock-size", required_argument, NULL, OPT_SPLITBLOCK_SIZE},
>>  	{0, 0, 0, 0}
>>  };
>>
>> @@ -9718,6 +9719,9 @@ main(int argc, char *argv[])
>>  		case OPT_CYCLIC_BUFFER:
>>  			info->bufsize_cyclic = atoi(optarg);
>>  			break;
>> +		case OPT_SPLITBLOCK_SIZE:
>> +			info->splitblock_size = atoi(optarg);
>> +			break;
>>  		case '?':
>>  			MSG("Commandline parameter is invalid.\n");
>>  			MSG("Try `makedumpfile --help' for more information.\n");
>> diff --git a/makedumpfile.h b/makedumpfile.h
>> index 60e6f2f..7bc57d9 100644
>> --- a/makedumpfile.h
>> +++ b/makedumpfile.h
>> @@ -1883,6 +1883,7 @@ struct elf_prstatus {
>>  #define OPT_EPPIC               OPT_START+12
>>  #define OPT_NON_MMAP            OPT_START+13
>>  #define OPT_MEM_USAGE            OPT_START+14
>> +#define OPT_SPLITBLOCK_SIZE		OPT_START+15
>>
>>  /*
>>   * Function Prototype.
>> diff --git a/print_info.c b/print_info.c
>> index f6342d3..2cdffd8 100644
>> --- a/print_info.c
>> +++ b/print_info.c
>> @@ -203,7 +203,21 @@ print_usage(void)
>>  	MSG("      By default, BUFFER_SIZE will be calculated automatically depending on\n");
>>  	MSG("      system memory size, so ordinary users don't need to specify this option.\n");
>>  	MSG("\n");
>> -	MSG("  [--non-cyclic]:\n");
>> +	MSG("  [--splitblock-size SPLITBLOCK_SIZE]:\n");
>> +	MSG("      Specify the splitblock size in kilo bytes for analysis in the cyclic mode\n");
>> +	MSG("      with --split.\n");
>> +	MSG("      In the cyclic mode, the number of splitblocks is represented as:\n");
>> +	MSG("\n");
>> +	MSG("          num_of_splitblocks = system_memory / (splitblock_size * 1KB)\n");
>
>Just the same as the above comment.
>
>> +	MSG("\n");
>> +	MSG("	   The larger number of splitblock, the faster working speed is expected, but\n");
>> +	MSG("	   the more memory will be taken. By default, splitblock_size will be set as\n");
>> +	MSG("	   1GB, so ordinary users don't need to specify this option.\n");
>> +	MSG("\n");
>> +	MSG("      The lesser number of cycles, the faster working speed is expected.\n");
>> +	MSG("      By default, BUFFER_SIZE will be calculated automatically depending on\n");
>> +	MSG("      system memory size, so ordinary users don't need to specify this option.\n");

In addition, the last segment is a duplicate of --cyclic-buffer's.


Thanks,
Atsushi Kumagai

>> +	MSG("\n");	MSG("  [--non-cyclic]:\n");
>>  	MSG("      Running in the non-cyclic mode, this mode uses the old filtering logic\n");
>>  	MSG("      same as v1.4.4 or before.\n");
>>  	MSG("      If you feel the cyclic mode is too slow, please try this mode.\n");
>> --
>> 1.7.1
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>--
>Thanks.
>HATAYAMA, Daisuke
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
