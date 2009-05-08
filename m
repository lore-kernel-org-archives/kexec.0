Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga05.intel.com ([192.55.52.89] helo=fmsmga101.fm.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1M2WX3-0005J1-MJ
	for kexec@lists.infradead.org; Fri, 08 May 2009 20:19:04 +0000
Message-ID: <4A0493B0.3090204@linux.intel.com>
Date: Fri, 08 May 2009 13:18:56 -0700
From: "H. Peter Anvin" <hpa@linux.intel.com>
MIME-Version: 1.0
Subject: Re: [PATCH 05/14] kbuild: allow compressors (gzip, bzip2, lzma) to
	take multiple inputs
References: <1241735222-6640-1-git-send-email-hpa@linux.intel.com>
	<1241735222-6640-6-git-send-email-hpa@linux.intel.com>
	<20090508074234.GD12808@uranus.ravnborg.org>
In-Reply-To: <20090508074234.GD12808@uranus.ravnborg.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ebiederm@xmission.com, ying.huang@intel.com, mingo@elte.hu, tglx@linutronix.de, vgoyal@redhat.com

Sam Ravnborg wrote:
>> diff --git a/scripts/bin_size b/scripts/bin_size
>> index 43e1b36..55f2161 100644
>> --- a/scripts/bin_size
>> +++ b/scripts/bin_size
>> @@ -1,10 +1,14 @@
>>  #!/bin/sh
>>  
>>  if [ $# = 0 ] ; then
>> -   echo Usage: $0 file
>> +   echo Usage: $0 file...
>>  fi
>>  
>> -size_dec=`stat -c "%s" $1`
>> +size_dec=0
>> +for file; do
>> +  fsize=`stat -c "%s" $file`
>> +  size_dec=`expr $size_dec + $fsize`
>> +done
>>  size_hex_echo_string=`printf "%08x" $size_dec |
>>       sed 's/\(..\)\(..\)\(..\)\(..\)/\\\\x\4\\\\x\3\\\\x\2\\\\x\1/g'`
>>  /bin/echo -ne $size_hex_echo_string
> 
> But I would rather have had this inside makefile.lib...
> 

It's messy enough as a shell script... it seems like baking it into 
Makefile syntax would make it even worse.

	-hpa


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
