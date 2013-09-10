Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJIR1-0003Na-Mz
 for kexec@lists.infradead.org; Tue, 10 Sep 2013 07:32:28 +0000
Message-ID: <522ECA5C.50204@mxc.nes.nec.co.jp>
Date: Tue, 10 Sep 2013 16:29:32 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: reverse -c and -p if using snappy
 compression
References: <E1VEnuJ-0000Js-Gl@eag09.americas.sgi.com>
 <20130830033450.GA12036@dhcp-16-252.nay.redhat.com>
 <CAJGZr0+fo-PhF7vbhR3qky_ab+jSLMF6JorAv+1+H2CBkijSMQ@mail.gmail.com>
In-Reply-To: <CAJGZr0+fo-PhF7vbhR3qky_ab+jSLMF6JorAv+1+H2CBkijSMQ@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: muvarov@gmail.com
Cc: d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org, cpw@sgi.com, bhe@redhat.com

Hello Maxim,

(2013/08/30 18:52), Maxim Uvarov wrote:
> I think that better is to have:
>
> -cz zlib
> -cs snappy
> -cl zlo

They are main options for most users, so I don't want to change
them without any important reason.

> -ca - automatic selection of compression. Snappy if compiled in, then
> lzo. And if no snappy and lzo then zlib.

What is the selection standard ? Compression Speed ?
If some users prefer compression ratio to compression speed,
snappy isn't suitable for them.

Each compression format has both good points and bad points,
so each user should select the format manually based on the
purpose in any case.


Thanks
Atsushi Kumagai

> this will make options more readable.
>
> Best regards.
> Maxim.
>
>
> 2013/8/30 Baoquan He <bhe@redhat.com>:
>> USESNAPPY is a switch which the snappy support has been built into.
>> With this flag, it means snappy compression algorithm is available.
>> Which compression algorithm is taken need be decided by -c/-l/-p.
>>
>> If I make a build with USELZO and USESNAPPY, then I want to test
>> zlib/lzo/snappy separately, then this patch will confuse me very
>> much. Current action and configuration are enough for me. So it's
>> better to leave the current action alone.
>>
>> Baoquan
>> Thanks
>>
>> On 08/28/13 at 05:08pm, Cliff Wickman wrote:
>>> From: Cliff Wickman <cpw@sgi.com>
>>>
>>> Reverse the meanings of -c (compression) and -p (snappy compression) if
>>> USESNAPPY is defined.
>>>
>>> The distro kdump scripts seem to only support -c for compression.
>>> So make -c mean snappy compression if it is supported.
>>>
>>> Diffed against makedumpfile-1.5.4
>>> Signed-off-by: Cliff Wickman <cpw@sgi.com>
>>> ---
>>>   makedumpfile.c |   10 ++++++++++
>>>   print_info.c   |   13 +++++++++----
>>>   2 files changed, 19 insertions(+), 4 deletions(-)
>>>
>>> Index: makedumpfile-1.5.4/makedumpfile.c
>>> ===================================================================
>>> --- makedumpfile-1.5.4.orig/makedumpfile.c
>>> +++ makedumpfile-1.5.4/makedumpfile.c
>>> @@ -8607,7 +8607,12 @@ main(int argc, char *argv[])
>>>                        info->name_filterconfig = optarg;
>>>                        break;
>>>                case 'c':
>>> +#ifdef USESNAPPY
>>> +                     /* if snappy is available make it the default */
>>> +                     info->flag_compress = DUMP_DH_COMPRESSED_SNAPPY;
>>> +#else
>>>                        info->flag_compress = DUMP_DH_COMPRESSED_ZLIB;
>>> +#endif
>>>                        break;
>>>                case 'D':
>>>                        flag_debug = TRUE;
>>> @@ -8656,7 +8661,12 @@ main(int argc, char *argv[])
>>>                        info->flag_dmesg = 1;
>>>                        break;
>>>                case 'p':
>>> +#ifdef USESNAPPY
>>> +                     /* is snappy is available only use zlib with -p */
>>> +                     info->flag_compress = DUMP_DH_COMPRESSED_ZLIB;
>>> +#else
>>>                        info->flag_compress = DUMP_DH_COMPRESSED_SNAPPY;
>>> +#endif
>>>                        break;
>>>                case 'P':
>>>                        info->xen_phys_start = strtoul(optarg, NULL, 0);
>>> Index: makedumpfile-1.5.4/print_info.c
>>> ===================================================================
>>> --- makedumpfile-1.5.4.orig/print_info.c
>>> +++ makedumpfile-1.5.4/print_info.c
>>> @@ -41,9 +41,9 @@ print_usage(void)
>>>   #endif
>>>        MSG("snappy support:\n");
>>>   #ifdef USESNAPPY
>>> -     MSG("  enabled\n");
>>> +     MSG("  enabled using -c\n");
>>>   #else
>>> -     MSG("  disabled ('-p' option will be ignored.)\n");
>>> +     MSG("  disabled\n");
>>>   #endif
>>>        MSG("\n");
>>>        MSG("Usage:\n");
>>> @@ -90,8 +90,13 @@ print_usage(void)
>>>        MSG("\n");
>>>        MSG("Available options:\n");
>>>        MSG("  [-c|-l|-p]:\n");
>>> -     MSG("      Compress dump data by each page using zlib for -c option, lzo for -l option\n");
>>> -     MSG("      or snappy for -p option. A user cannot specify either of these options with\n");
>>> +#ifdef USESNAPPY
>>> +     MSG("      Compress dump data by each page using zlib for -p option, lzo for -l option\n");
>>> +     MSG("      or snappy for -c option. A user cannot specify any of these options with\n");
>>> +#else
>>> +     MSG("      Compress dump data by each page using zlib for -c option or lzo for -l option\n");
>>> +     MSG("      A user cannot specify either of these options with\n");
>>> +#endif
>>>        MSG("      -E option, because the ELF format does not support compressed data.\n");
>>>        MSG("      THIS IS ONLY FOR THE CRASH UTILITY.\n");
>>>        MSG("\n");
>>>
>>> _______________________________________________
>>> kexec mailing list
>>> kexec@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/kexec
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>
>
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
